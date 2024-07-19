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
    func toggleLearnedFlashcard(flashcardID:UUID){
        viewmodel.toggleLearnedFlashcard(flashcardID: flashcardID)
    }
    func toggleStillLearningFlashcard(flashcardID:UUID){
        viewmodel.toggleStillLearninigFlashcard(flashcardID: flashcardID)
    }
    
    
    
    
}

extension FlashCardListViewController: SwipeCollectionViewCellDelegate{
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        let flashcard = viewmodel.flashcard(by: indexPath.row)
        switch(orientation){
        case .left:
            let stillLearningAction = SwipeAction(style: .default, title: nil) { [weak self] action, indexPath in
                guard let self = self else {return}
                print("still learning")
                toggleStillLearningFlashcard(flashcardID: flashcard.id)
            }
            
            
            stillLearningAction.title = "still learning"
            stillLearningAction.font = viewmodel.subtitleFont
            stillLearningAction.backgroundColor = .darkRed.withAlphaComponent(0.5)
            return [stillLearningAction]
            
        
        case .right: 
            let learnedAction = SwipeAction(style: .default, title: nil) { [weak self ] action, indexPath in
                guard let self = self else {return}
                print("already know")
                toggleLearnedFlashcard(flashcardID: flashcard.id)

                
            }
     
            learnedAction.title = "Know"
            learnedAction.font = viewmodel.subtitleFont
            learnedAction.backgroundColor = .darkGreen
            return [learnedAction]
            
        
        }
    }
    
    
}
