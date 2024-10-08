//
//  DetailsViewDataSource.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import Foundation
import UIKit
import SwipeCellKit




extension TopicViewController: UICollectionViewDelegate{
    
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
//    
//    func deleteMap(at indexPath: IndexPath){
//        let alert = UIAlertController(
//            title: "Are you sure you want to delete map?",
//            message: "This action cannot be undone",
//            preferredStyle: .alert)
//        alert.addAction(
//            UIAlertAction(
//                title: "cancel",
//                style: .default,
//                handler: {[weak self] UIAlertAction in
//                    self?.dismiss(animated: true)
//                }
//            ))
//        alert.addAction(
//            UIAlertAction(
//                title: "delete map",
//                style: .destructive,
//                handler: {[weak self] UIAlertAction in
//                    
//                    guard let map = self?.viewmodel.map(by: indexPath.row) else {
//                        fatalError("Couldn't delete map")
//                    }
//                    //self?.viewmodel.deleteMap(map: map)
//                    self?.deleteMapFromCollectionView(indexPath: indexPath)
//                 
//                }
//                
//            ))
//        
//        present(alert, animated: true)
//    }
    
    func deleteTopicFromCollectionView(indexPath: IndexPath){
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                if self.viewmodel.numberOfTopics > 0 {
                    self.collectionView.deleteItems(at: [indexPath])
                  

                }
//                else if self.viewmodel.numberOfTopics == 0 && self.viewmodel.numberOfMaps == 0{
                else if self.viewmodel.numberOfTopics == 0 {
                    //MARK: executed when there are about to be no flashcards or topics.
                    print("executed when there are about to be no flashcards or topics")
                    let indexSet = IndexSet(integer:indexPath.section)
                    self.viewmodel.sections.remove(at:  0)
                    self.collectionView.deleteSections(indexSet)
                }
                
                
                else{
                    print("index path in delete topic:\(indexPath.section)")
                    //if self.viewmodel.topicMapPrecedence == 0 && self.viewmodel.numberOfTopics == 0{
                    if  self.viewmodel.numberOfTopics == 0{

                       // self.viewmodel.setOpenedFirst(subjectID: self.viewmodel.subjectID, openedFirst: 1)

                        self.collectionView.reloadSections(IndexSet(integer: indexPath.section == 0 ? 1 : 0))

                    }
                    self.viewmodel.sections.remove(at:  indexPath.section)

                    let indexSet = IndexSet(integer:indexPath.section)

                    self.collectionView.deleteSections(indexSet)


                }
                print("sections count in dtfcv: \(self.viewmodel.sections.count)")

            },completion: { finished in
                if finished{
//                    if (self.viewmodel.mapsIsEmpty && self.viewmodel.topicMapPrecedence == 1){
//                      //  self.viewmodel.setOpenedFirst(subjectID: self.viewmodel.subjectID, openedFirst: -1)
//
//                    }
                }
                self.navigationItem.rightBarButtonItem = self.createOptionsBarButtonItem()

            })
        }

        //updateTopicAndMapCountInSubjectCollectionViewDelegate?.didUpdateTopicMapCountInSubjectCollectionViewFromTopicMapViewController(subjectIndexPath: subjectIndexPath)

    }
    
//    func deleteMapFromCollectionView(indexPath:IndexPath){
//        DispatchQueue.main.async {
//            self.collectionView.performBatchUpdates({
//                if self.viewmodel.numberOfMaps > 0 {
//                    self.collectionView.deleteItems(at: [indexPath])
//
//                }
//                else if self.viewmodel.numberOfTopics == 0 && self.viewmodel.numberOfMaps == 0{
//                    print("executed when there are about to be no flashcards or topics")
//                    let indexSet = IndexSet(integer:indexPath.section)
//                    self.viewmodel.sections.remove(at:  0)
//                    self.collectionView.deleteSections(indexSet)
//                }
//                else{
//                    print("index path in delete map:\(indexPath.section)")
//                    //if self.viewmodel.topicMapPrecedence == 1 && self.viewmodel.numberOfMaps == 0{
//                    if  self.viewmodel.numberOfMaps == 0{
//                       // self.viewmodel.setOpenedFirst(subjectID: self.viewmodel.subjectID, openedFirst: 0)
//                        self.collectionView.reloadSections(IndexSet(integer: indexPath.section == 0 ? 1 : 0))
//
//                    }
//                    print("section to remove: \(indexPath.section)")
//                    self.viewmodel.sections.remove(at:  indexPath.section)
//                    let indexSet = IndexSet(integer:  indexPath.section)
//                    self.collectionView.deleteSections(indexSet)
//                }
//                
//            },completion: { finished in
//                if finished{
//                    //if self.viewmodel.topicsIsEmpty && self.viewmodel.topicMapPrecedence == 0 {
//                    if self.viewmodel.topicsIsEmpty  {
//                       // self.viewmodel.setOpenedFirst(subjectID: self.viewmodel.subjectID, openedFirst: -1)
//                        print("sections count in dtfcv: \(self.viewmodel.sections.count)")
//
//                    }
//                    self.navigationItem.rightBarButtonItem = self.createOptionsBarButtonItem()
//
//                }
//            })
//        }
//
//       // updateTopicAndMapCountInSubjectCollectionViewDelegate?.didUpdateTopicMapCountInSubjectCollectionViewFromTopicMapViewController(subjectIndexPath: subjectIndexPath)
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = TopicOptionsViewController(topicID: viewmodel.topic(by: indexPath.row).id, topicIndexPath: indexPath)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
//        if viewmodel.sectionType(for: indexPath.section)  == .topics{
//            let vc = TopicOptionsViewController(topicID: viewmodel.topic(by: indexPath.row).id, topicIndexPath: indexPath)
//            vc.delegate = self
//            navigationController?.pushViewController(vc, animated: true)
//
//        }
    }
}

extension TopicViewController: SwipeCollectionViewCellDelegate{
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {

        switch(orientation){
        case .left:
            
            let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
               // if self.viewmodel.sectionType(for: indexPath.section ) == .topics{
                    self.deleteTopic(at: indexPath)
                //}else{
                //    self.deleteMap(at: indexPath)
              //  }
                self.navigationItem.rightBarButtonItem = self.createOptionsBarButtonItem()
                
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

