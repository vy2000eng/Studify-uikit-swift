//
//  SetViewCollectionsManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation

//MARK: - delegate functions
extension FlashCardSetViewController{
    
    func didAddFlashcardToSet() {
        
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 0)
        let indexPathSmallSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 1)
        self.viewmodel.currentIndex = indexPathSetCell.row
        
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
               
                if self.viewmodel.numberOfFlashCards == 1{
                    
                    self.collectionView.insertSections(IndexSet(integer: 0))
                    self.collectionView.insertSections(IndexSet(integer: 1))
                }else{
                    
                    self.viewmodel.isSectionCollapsed() ?
                    self.collectionView.insertItems(at: [indexPathSetCell,indexPathSmallSetCell]) :
                    self.collectionView.insertItems(at: [indexPathSetCell])
                }
            } ,completion: {finished in
                if finished{
                    self.collectionView.scrollToItem(at: indexPathSetCell, at: .right, animated: true)
                }
            })
        }
        addFlashCardInListViewControllerDelegate?.didAddFlashCardInListViewControllerFromSetViewController()
    }
    
    func didUpdateFlashCardInSet(indexPath: IndexPath) {
        
        print("did update in set called")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: indexPath.row, section: 0)
        let indexPathSmallSetCell = IndexPath(row: indexPath.row, section: 1)
        self.viewmodel.currentIndex = indexPath.row
        
        DispatchQueue.main.async {
           
            self.collectionView.performBatchUpdates({
               
                self.viewmodel.isSectionCollapsed() ?
                self.collectionView.reconfigureItems(at: [indexPathSetCell, indexPathSmallSetCell]):
                self.collectionView.reconfigureItems(at: [indexPathSetCell])
            }, completion: { finished  in
                
                if finished{
                    self.configureScrollBehavior(indexPath: indexPath, updateDelete: 1)
                }
            })
        }
        updateFlashCardInListViewControllerDelegate?.didUpdateFlashCardInListViewControllerFromSetViewController(indexPath: indexPath)
    }
    
    func didDeleteFlashCardInSet(indexPath: IndexPath) {
        
        print("didUpdateFlashcard called in set vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: indexPath.row, section: 0)
        let indexPathSmallSetCell = IndexPath(row: indexPath.row, section: 1)
        let newIndexPathForList = indexPath.row == 0 ? IndexPath(row: 0, section: 0) : IndexPath(row: max(0, indexPath.row - 1), section: 0)
        
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                if self.viewmodel.numberOfFlashCards == 0{
                    self.collectionView.deleteSections(IndexSet(integer: 0))
                    self.collectionView.deleteSections(IndexSet(integer: 1))
                }else{
                    self.viewmodel.isSectionCollapsed() ?
                    self.collectionView.deleteItems(at: [indexPathSetCell, indexPathSmallSetCell]) :
                    self.collectionView.deleteItems(at: [indexPathSetCell])
                }
            }, completion: { finished in
                
                if finished{
                    
                    self.configureScrollBehavior(indexPath: indexPath, updateDelete: 0)
                }
            })
        }
        updateFlashCardInListViewControllerDelegate?.didDeleteFlashCardInListViewControllerFromSetViewController(indexPath: indexPath, newIndexPathForList: newIndexPathForList)
    }
    
    
    func configureScrollBehavior(indexPath: IndexPath, updateDelete:Int){
        
        var newPosition = updateDelete == 0 ? indexPath.row - 1 :  indexPath.row// Default to one less than the deleted item
        // Check bounds and adjust if necessary
        if newPosition < 0 && self.viewmodel.numberOfFlashCards > 0 {
            newPosition = 0 // Set to the first item if we deleted the first item
        } else if newPosition >= self.viewmodel.numberOfFlashCards {
            newPosition = max(0, self.viewmodel.numberOfFlashCards - 1)  // Set to the last item if out of bounds
            
        }
        if self.viewmodel.numberOfFlashCards > 0 {
            let indexPathSetCell = IndexPath(row: newPosition, section: 0)
            let indexPathSmallSetCell = IndexPath(row: newPosition, section: 1)
            self.viewmodel.currentIndex = indexPathSmallSetCell.row
            switch newPosition {
            case 0:
                self.collectionView.reloadItems(at: [indexPathSmallSetCell])
                self.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredHorizontally, animated: true)
                break
            case self.viewmodel.numberOfFlashCards-1 :
                self.collectionView.scrollToItem(at: indexPathSetCell , at: .centeredHorizontally, animated: false)
                break
            default:
                self.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredHorizontally, animated: true)
                break
            }
        }
    }
}
