//
//  FlashCardSetViewControllerDelegate.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/22/24.
//

import Foundation
import UIKit

extension FlashCardSetViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bottomIndexPath = IndexPath(row: indexPath.row, section: 1)
        if indexPath.section == 0{

            guard let cell = collectionView.cellForItem(at: indexPath) as? FlashCardSetCollectionViewCell else {
                   return
               }
            let options: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
               let duration = 0.5

               UIView.transition(with: cell, duration: duration, options: options, animations: {
                   let flashcard = self.viewmodel.flashcard(by: indexPath.row)
                   self.viewmodel.flashcardDisplayMode(by: indexPath.row)

                   cell.configure(flashcard: flashcard, bottomTopStyle: 0)
               }, completion: {_ in
                           DispatchQueue.main.async{
                               self.collectionView.performBatchUpdates {
                                   self.collectionView.reloadItems(at: [bottomIndexPath])
                               }
                           }
               })
        }
        
       else{
            let newIndexPath = IndexPath(item: indexPath.row, section: 0)
            DispatchQueue.main.async{
                self.collectionView.performBatchUpdates {
                    self.collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
                }
            }
        }
    }
}
