//
//  DetailsViewDataSource.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import Foundation
import UIKit
import SwipeCellKit


extension TopicMapViewController: UICollectionViewDelegate{
    
    func deleteTopic(at indexPath: IndexPath){
        let alert = UIAlertController(
            title: "Are you sure you want to delete topic?",
            message: "This action cannot be undone",
            preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "cancel",
                style: .default,
                handler: {[weak self] UIAlertAction in
                    self?.dismiss(animated: true)
                }
            ))
        alert.addAction(
            UIAlertAction(
                title: "delete",
                style: .destructive,
                handler: {[weak self] UIAlertAction in
                    
                    guard let topic = self?.viewmodel.topic(by: indexPath.row) else {
                        fatalError("Couldn't delete topic")
                    }
                    self?.viewmodel.deleteTopic(topic: topic)
                    
                    self?.deleteTopicFromCollectionView(indexPath: indexPath)
                }
                
            ))
        
        present(alert, animated: true)
        
    }
    
    func deleteMap(at indexPath: IndexPath){
        let alert = UIAlertController(
            title: "Are you sure you want to delete map?",
            message: "This action cannot be undone",
            preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "cancel",
                style: .default,
                handler: {[weak self] UIAlertAction in
                    self?.dismiss(animated: true)
                }
            ))
        alert.addAction(
            UIAlertAction(
                title: "delete map",
                style: .destructive,
                handler: {[weak self] UIAlertAction in
                    
                    guard let map = self?.viewmodel.map(by: indexPath.row) else {
                        fatalError("Couldn't delete map")
                    }
                    self?.viewmodel.deleteMap(map: map)
                    self?.deleteMapFromCollectionView(indexPath: indexPath)
                 
                }
                
            ))
        
        present(alert, animated: true)
    }
    
    func deleteTopicFromCollectionView(indexPath: IndexPath){
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                if self.viewmodel.numberOfTopics > 0 {
                    self.collectionView.deleteItems(at: [indexPath])
                  

                }
                else if self.viewmodel.numberOfTopics == 0 && self.viewmodel.numberOfMaps == 0{
                    print("executed when there are about to be no flashcards or topics")
                    let indexSet = IndexSet(integer:indexPath.section)
                    self.viewmodel.sections.remove(at:  0)
                   // self.viewmodel.sections.remove(at:  1)

                    


                    self.collectionView.deleteSections(indexSet)
                    
                    
                }
                
                
                else{
                    print("index path in delete topic:\(indexPath.section)")
                    if self.viewmodel.topicMapPrecedence == 0 && self.viewmodel.numberOfTopics == 0{
                        self.viewmodel.setOpenedFirst(subjectID: self.viewmodel.subjectID, openedFirst: 1)
                        self.viewmodel.sections.remove(at:  indexPath.section)
                        
                        self.collectionView.reloadSections(IndexSet(integer: indexPath.section == 0 ? 1 : 0))

                    }
                    print("sections count in dtfcv: \(self.viewmodel.sections.count)")
                    let indexSet = IndexSet(integer:indexPath.section)

                    self.collectionView.deleteSections(indexSet)


                }
            },completion: { finished in
                if finished{
                    if (self.viewmodel.mapsIsEmpty && self.viewmodel.topicMapPrecedence == 1){
                        self.viewmodel.setOpenedFirst(subjectID: self.viewmodel.subjectID, openedFirst: -1)
                    }
                }
            })
        }
    }
    
    func deleteMapFromCollectionView(indexPath:IndexPath){
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                if self.viewmodel.numberOfMaps > 0 {
                    self.collectionView.deleteItems(at: [indexPath])

                }
                else if self.viewmodel.numberOfTopics == 0 && self.viewmodel.numberOfMaps == 0{
                    print("executed when there are about to be no flashcards or topics")
                    let indexSet = IndexSet(integer:indexPath.section)
                    self.viewmodel.sections.remove(at:  0)
                    self.collectionView.deleteSections(indexSet)
                }
                else{
                    print("index path in delete map:\(indexPath.section)")
                    if self.viewmodel.topicMapPrecedence == 1 && self.viewmodel.numberOfMaps == 0{
                        self.viewmodel.setOpenedFirst(subjectID: self.viewmodel.subjectID, openedFirst: 0)
                        self.viewmodel.sections.remove(at:  indexPath.section)
                        self.collectionView.reloadSections(IndexSet(integer: indexPath.section == 0 ? 1 : 0))

                    }
                    print("section to remove: \(indexPath.section)")
                    let indexSet = IndexSet(integer:  indexPath.section)
                    self.collectionView.deleteSections(indexSet)
                }
                
            },completion: { finished in
                if finished{
                    if self.viewmodel.topicsIsEmpty && self.viewmodel.topicMapPrecedence == 0 {
                        self.viewmodel.setOpenedFirst(subjectID: self.viewmodel.subjectID, openedFirst: -1)
                    }
                }
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if viewmodel.sectionType(for: indexPath.section)  == .topics{
            let vc = FlashCardTabViewController(topicID: viewmodel.topic(by: indexPath.row).id, topicIndexPath: indexPath)
            vc.flashcardSetViewController.delegate = self
            vc.flashcardListViewController.delegate = self
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

extension TopicMapViewController: SwipeCollectionViewCellDelegate{
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {

        
                //guard orientation == .left else { return nil }
        switch(orientation){
        case .left:
            let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
                if self.viewmodel.sectionType(for: indexPath.section ) == .topics{
                    self.deleteTopic(at: indexPath)
                    
                }else{
                    self.deleteMap(at: indexPath)
                }
            }
            deleteAction.image = UIImage(systemName: "trash")
            return [deleteAction]
            
        case .right:
            
            let favoriteAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                print("fave tapped")
            }
            
            favoriteAction.image = UIImage(systemName: "star")
            favoriteAction.backgroundColor = .orange
            return [favoriteAction]
        }

       
      
    }
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
           var options = SwipeOptions()
           options.expansionStyle = .none
           options.transitionStyle = .drag
           return options
       }
  
}

