//
//  FlashCardListViewControllerDelegate.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/25/24.
//

import Foundation
import UIKit
import SwipeCellKit
extension FlashCardListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
}

extension FlashCardListViewController: SwipeCollectionViewCellDelegate{
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        switch(orientation){
        case .left: 
            let stillLearningAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                print("still learning")
            }
            
            //stillLearningAction.image = UIImage(systemName: "star")
            stillLearningAction.title = "still learning"
            stillLearningAction.font = viewmodel.subtitleFont
            stillLearningAction.backgroundColor = .darkRed.withAlphaComponent(0.5)
            return [stillLearningAction]
            
        
        case .right: 
            let learnedAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                print("already know")
            }
            
            //learnedAction.image = UIImage(systemName: "star")
          //  learnedAction.image = UIImage(systemName: "")
            learnedAction.title = "Know"
            learnedAction.font = viewmodel.subtitleFont
            learnedAction.backgroundColor = .darkGreen
            return [learnedAction]
            
        
        }
    }
    
    
}
