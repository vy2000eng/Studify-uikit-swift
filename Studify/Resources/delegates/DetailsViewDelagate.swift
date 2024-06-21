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
                    DispatchQueue.main.async {
                            self?.collectionView.deleteItems(at: [indexPath])
                    }
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
                    DispatchQueue.main.async {
                        self?.collectionView.deleteItems(at: [indexPath])
                    }
                }
                
            ))
        
        present(alert, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let vc = FlashCardTabViewController(topicID: viewmodel.topic(by: indexPath.row).id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }    
}

extension TopicMapViewController: SwipeCollectionViewCellDelegate{
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .left else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            if indexPath.section == 0{
                self.deleteTopic(at: indexPath)
                
            }else{
                self.deleteMap(at: indexPath)
            }
        }
        deleteAction.image = UIImage(named: "delete_icon")
        return [deleteAction]
    }
}
