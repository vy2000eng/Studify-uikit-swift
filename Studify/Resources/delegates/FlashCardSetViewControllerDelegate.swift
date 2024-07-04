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
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let bottomIndexPath = IndexPath(row: indexPath.row, section: 1)
            guard let cell = collectionView.cellForItem(at: bottomIndexPath) as? FlashCardSetCollectionViewCell else {
                return
            }
            cell.mainView.backgroundColor = warmTreeTones.lightTertiary!.withAlphaComponent(0.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
            let bottomIndexPath = IndexPath(row: indexPath.row, section: 1)
            print(bottomIndexPath.row)
            guard let cell = collectionView.cellForItem(at: bottomIndexPath) as? FlashCardSetCollectionViewCell else {
                return
            }
            viewmodel.currentIndex = indexPath.row
            cell.mainView.backgroundColor = warmTreeTones.lightPrimary
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bottomIndexPath = IndexPath(row: indexPath.row, section: 1)
        if indexPath.section == 0{

            let cell = collectionView.cellForItem(at: indexPath) as! FlashCardSetCollectionViewCell
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
            
            let topIndexPath = IndexPath(item: indexPath.row, section: 0)
            DispatchQueue.main.async{
                self.collectionView.performBatchUpdates {
                    self.collectionView.scrollToItem(at: topIndexPath, at: .centeredHorizontally, animated: true)
                }
            }
        }
    }
}
