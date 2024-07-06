//
//  ListViewCollectionsManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation
extension FlashCardListViewController{
    func didAddFlashcardToList() {
        
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 0)
        self.viewmodel.currentIndex = indexPathSetCell.row
        
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.insertItems(at: [indexPathSetCell])
            },completion: { finished in
                if finished {
                    self.collectionView.scrollToItem(at: indexPathSetCell, at: .bottom, animated: true)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.highlightCell(at: indexPathSetCell)
                    }
                }
            })
        }
        
        //MARK: Tada what did I say!?
        //MARK: I said: " "updateFlashCardInSetViewControllerFromListViewController()" is called right after updates are made to the UI inside of "didAddFlashcardToList()" "
        //MARK: if you dont get it read the comment at the top of this file: "MARK: updateFlashCardInSetViewControllerFromListViewController()".
        addFlashCardInSetViewControllerDelegate?.didAddFlashCardToSetViewControllerFromListViewController()
    }
    
    
    func didUpdateFlashCardInList(indexPath: IndexPath) {
      
        viewmodel.getAllFlashcards()
        let indexPathListCell = IndexPath(row: indexPath.row, section: 0)
        self.viewmodel.currentIndex = indexPathListCell.row
        
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.reloadItems(at: [indexPathListCell])
            } ,completion: { finished in
                if finished {
                    self.collectionView.scrollToItem(at: indexPathListCell, at: .centeredVertically, animated: true)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.highlightCell(at: indexPathListCell)
                    }
                }
            })
        }
        updateFlashCardInSetViewControllerDelegate?.didUpdateFlashCardInSetViewControllerFromListViewController(indexPath: indexPath)
    }
    
    func didDeleteFlashCardInList(indexPath: IndexPath) {
        
        viewmodel.getAllFlashcards()
        let indexPathListCell = IndexPath(row: indexPath.row, section: 0)
        self.viewmodel.currentIndex = indexPath.row == 0 ? 0 : max(0, indexPath.row - 1)
                
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.deleteItems(at: [indexPathListCell])
            }, completion: { finished in
                if finished {
                    // Scroll to the new current index if needed
                    if self.viewmodel.numberOfFlashCards > 0 {
                        let newIndexPath = IndexPath(row: self.viewmodel.currentIndex, section: 0)
                        self.collectionView.scrollToItem(at: newIndexPath, at: .centeredVertically, animated: true)
                       
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.highlightCell(at: newIndexPath)
                        }
                    }
                }
            })
        }
        updateFlashCardInSetViewControllerDelegate?.didDeleteFlashCardInSetViewControllerFromListViewController(indexPath: indexPath)
    }
}
