//
//  FlashCardSetViewControllerDelegate.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/22/24.
//

import Foundation
import UIKit

extension FlashCardSetViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let newIndexPath = IndexPath(item: indexPath.row, section: 0)
            DispatchQueue.main.async{
                self.collectionView.performBatchUpdates {
                    self.collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
                }
            }
        }
    }
}
