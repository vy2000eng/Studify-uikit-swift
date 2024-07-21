//
//  FlashCardListViewControllerDelegate.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/25/24.
//

import Foundation
import UIKit
import SwipeCellKit
import NotificationBannerSwift

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
        let banner = NotificationBanner(title: "move notification",subtitle: "", style: .info)
        banner.dismissOnSwipeUp = true
        banner.dismissOnTap = true
        banner.duration = 5
        
        var action: [SwipeCellKit.SwipeAction] = []
        
        if viewmodel.sectionTitle == .stillLearningFlashCards && orientation == .right{
            guard orientation == .right else {return nil}
            let learnedAction = SwipeAction(style: .default, title: nil) { [weak self ] action, indexPath in
                guard let self = self else {return}
                print("already know")
                toggleLearnedFlashcard(flashcardID: flashcard.id)
                viewmodel.getStillLearningFlashcards()
                DispatchQueue.main.async{
                    banner.subtitleLabel?.text = "Flashcard Has Been Moved To Learned Flashcards"
                    banner.show(bannerPosition: .top)

                    UIView.animate(withDuration: 0.3, animations:{
                        self.collectionView.deleteItems(at: [indexPath])
                    })
                }
                
            }
            
            learnedAction.title = "Know"
            learnedAction.font = viewmodel.subtitleFont
            learnedAction.backgroundColor = .darkGreen
            action.append(learnedAction)
          
            
        }
        if viewmodel.sectionTitle == .learnedFlashCards && orientation == .right{
            guard orientation == .right else {return nil}
            let stillLearningAction = SwipeAction(style: .default, title: nil) { [weak self] action, indexPath in
                guard let self = self else {return}
                print("still learning")
                toggleStillLearningFlashcard(flashcardID: flashcard.id)
                viewmodel.getLearnedFlashcards()
                DispatchQueue.main.async{
                    banner.subtitleLabel?.text = "Flashcard Has Been Moved To Still Learning"

                    banner.show(bannerPosition: .top)

                    UIView.animate(withDuration: 0.3, animations:{
                        self.collectionView.deleteItems(at: [indexPath])

                    })
                }
               
            }
            stillLearningAction.title = "learning"
            stillLearningAction.font = viewmodel.subtitleFont
            stillLearningAction.backgroundColor = .darkRed.withAlphaComponent(0.5)
            action.append(stillLearningAction)
            
            
        }
        return action
    }
}
    

//        switch(orientation){
//        case .left:
//            let stillLearningAction = SwipeAction(style: .default, title: nil) { [weak self] action, indexPath in
//                guard let self = self else {return}
//                print("still learning")
//                toggleStillLearningFlashcard(flashcardID: flashcard.id)
//                banner.show(bannerPosition: .top )
//                
//            }
//            
//            
//            stillLearningAction.title = "still learning"
//            stillLearningAction.font = viewmodel.subtitleFont
//            stillLearningAction.backgroundColor = .darkRed.withAlphaComponent(0.5)
//            return [stillLearningAction]
//        
//        case .right: 
//            let learnedAction = SwipeAction(style: .default, title: nil) { [weak self ] action, indexPath in
//                guard let self = self else {return}
//                print("already know")
//                toggleLearnedFlashcard(flashcardID: flashcard.id)
//
//                
//            }
//     
//            learnedAction.title = "Know"
//            learnedAction.font = viewmodel.subtitleFont
//            learnedAction.backgroundColor = .darkGreen
//            return [learnedAction]
////            
//        
//        }
    //}
    
    
//}
