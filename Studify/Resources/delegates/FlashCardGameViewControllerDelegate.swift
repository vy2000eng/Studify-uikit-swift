//
//  FlashCardGameViewControllerDelegate.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/21/24.
//

import Foundation
import UIKit
import SwipeCellKit

extension FlashCardGameViewController:UICollectionViewDelegate{
    
}

extension FlashCardGameViewController:SwipeCollectionViewCellDelegate{
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        switch(orientation){
        case .left:
            let stillLearningAction = SwipeAction(style: .default, title: nil) { [weak self ] action, indexPath in
                print("stillLearning")
            }
            stillLearningAction.backgroundColor = .darkRed.withAlphaComponent(0.5)

            
            return [stillLearningAction]

            
            
            
        case .right:
            let learnedAction = SwipeAction(style: .default, title: nil) { [weak self ] action, indexPath in
                print("learned")
            }
            learnedAction.backgroundColor = .darkGreen
            return [learnedAction]
            
        }
    }
    
    
}
