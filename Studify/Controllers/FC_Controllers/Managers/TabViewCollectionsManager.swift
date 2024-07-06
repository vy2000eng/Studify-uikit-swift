//
//  FlashCardCollectionsManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation
extension FlashCardTabViewController{
    //delegate functions
    //extension FlashCardTabViewController{
        //MARK: EXPLANATION
        //MARK: The "if flashcardListViewController.isViewLoaded" is because of the way TabViewControllers work when you have tabs.
        //      1. "FlashCardTabViewController" is loaded into memory.
        //      2. "FlashCardSetViewController" is loaded into memory, because it is the first ViewController added to "FlashCardTabViewController"
        //MARK: 3. "FlashCardListViewController" is loaded into memory, ONLY AFTER IT IS CLICKED ON.
        //      4.  None of the other viewControllers ever get reloaded after they load once.
        //MARK: This presents a problem:
        // 1.) If you decide to make UIChanges in "FlashCardSetViewController" and you HAVE NOT clicked on "FlashCardListViewController", then all of the changed you made in
        //     "FlashCardSetViewController" will load beautifully into "FlashCardListViewController" without you needing to do anything at all, except for updating changes you made
        //      in "FlashCardSetViewController" but ONLY ONE TIME!
        //MARK: ADD
        func didAddFlashCardToSetViewControllerFromListViewController() {
            if flashcardSetViewController.isViewLoaded{
                didAddFlashcardToSet()
            }
        }
        
        func didAddFlashCardInListViewControllerFromSetViewController() {
            if flashcardListViewController.isViewLoaded{
                didAddFlashcardToList()
            }
            
        }
        //MARK: UPADTE
        func didUpdateFlashCardInSetViewControllerFromListViewController(indexPath:IndexPath) {
            if flashcardSetViewController.isViewLoaded{
                didUpdateFlashCardInSet(indexPath: indexPath)
            }
        }
        
        func didUpdateFlashCardInListViewControllerFromSetViewController(indexPath:IndexPath) {
            if flashcardListViewController.isViewLoaded{
                didUpdateFlashCardInList(indexPath: indexPath)
            }
            
        }
        //MARK: DELETE
        func didDeleteFlashCardInSetViewControllerFromListViewController(indexPath: IndexPath) {
            if flashcardSetViewController.isViewLoaded{
                didDeleteFlashCardInSet(indexPath: indexPath)
            }
        }
        
        func didDeleteFlashCardInListViewControllerFromSetViewController(indexPath: IndexPath, newIndexPathForList: IndexPath) {
            if flashcardListViewController.isViewLoaded{
                didDeleteFlashCardInList(indexPath: indexPath, newIndexPathForList: newIndexPathForList)
            }
        }

    }


extension FlashCardTabViewController{
    //MARK: DELETE
    func didDeleteFlashCardInList(indexPath: IndexPath, newIndexPathForList: IndexPath){
        
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: indexPath.row, section: 0)
        
        DispatchQueue.main.async {
            self.flashcardListViewController.collectionView.performBatchUpdates({
                self.flashcardListViewController.collectionView.deleteItems(at: [indexPathSetCell])
            },completion: { finished in
                if finished{
                    DispatchQueue.main.async{
                        self.flashcardListViewController.collectionView.scrollToItem(at: newIndexPathForList, at: .bottom, animated: false)
                    }
                }
                
            })
        }
    }
    
    func didDeleteFlashCardInSet(indexPath:IndexPath){
        
        viewmodel.getAllFlashcards()
        //were using this to delete the item, that is in fact deleted, but still in the list via the ui
        let indexPathSetCell = IndexPath(row:indexPath.row, section: 0)
        let indexPathSmallSetCell = IndexPath(row: indexPath.row, section: 1)
        
        DispatchQueue.main.async {
            self.flashcardSetViewController.collectionView.performBatchUpdates({
                if self.viewmodel.numberOfFlashCards == 0{
                    self.flashcardSetViewController.collectionView.deleteSections(IndexSet(integer: 0))
                    self.flashcardSetViewController.collectionView.deleteSections(IndexSet(integer: 1))
                }else{
                    self.viewmodel.isSectionCollapsed() ?
                    self.flashcardSetViewController.collectionView.deleteItems(at: [indexPathSetCell,indexPathSmallSetCell]):
                    self.flashcardSetViewController.collectionView.deleteItems(at: [indexPathSetCell])
                }
                
            },completion: { finished in
                if finished{
                    self.flashcardSetViewController.collectionView.layoutIfNeeded()
                    DispatchQueue.main.async {
                        if self.viewmodel.numberOfFlashCards > 0 {
                            // were using this to delete scroll to the new item that was determined in
                            let updatedIndexPathSetCell = IndexPath(row: self.viewmodel.currentIndex, section: 0)
                            self.flashcardSetViewController.collectionView.scrollToItem(at: updatedIndexPathSetCell, at: .centeredHorizontally, animated: false)
                        }
                    }
                }
            })
        }
    }
    //MARK: UPDATE
    func didUpdateFlashCardInList(indexPath:IndexPath){
        
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: indexPath.row, section: 0)
        
        DispatchQueue.main.async {
            self.flashcardListViewController.collectionView.performBatchUpdates({
                self.flashcardListViewController.collectionView.reloadItems(at: [indexPathSetCell])
            },completion: {finished in
                if finished{
                    self.flashcardListViewController.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredVertically, animated: false)
                }
                
            })
        }
    }
    
    func didUpdateFlashCardInSet(indexPath:IndexPath){
        
        viewmodel.getAllFlashcards()
        
        let indexPathSetCell = IndexPath(row:self.viewmodel.currentIndex, section: 0)
        let indexPathSmallSetCell = IndexPath(row: self.viewmodel.currentIndex, section: 1)
        
        DispatchQueue.main.async {
            self.flashcardSetViewController.collectionView.performBatchUpdates({
                self.viewmodel.isSectionCollapsed() ?
                self.flashcardSetViewController.collectionView.reloadItems(at: [indexPathSetCell,indexPathSmallSetCell]):
                self.flashcardSetViewController.collectionView.reloadItems(at: [indexPathSetCell])
            },completion: { finished in
                if finished{
                    self.flashcardSetViewController.collectionView.layoutIfNeeded()
                    DispatchQueue.main.async {
                        
                        self.flashcardSetViewController.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredHorizontally, animated: false)
                    }
                }
                
            })
        }
    }
    
    //MARK: ADD
    func didAddFlashcardToList() {
        
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 0)
        
        DispatchQueue.main.async {
            self.flashcardListViewController.collectionView.performBatchUpdates({
                self.flashcardListViewController.collectionView.insertItems(at: [indexPathSetCell])
            },completion: { finished in
                self.flashcardListViewController.collectionView.layoutIfNeeded()
                DispatchQueue.main.async{
                    self.flashcardListViewController.collectionView.scrollToItem(at: indexPathSetCell, at: .bottom, animated: false)
                }
                
            })
        }
    }
    
    func didAddFlashcardToSet() {
        
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 0)
        let indexPathSmallSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 1)
        
        DispatchQueue.main.async {
            self.flashcardSetViewController.collectionView.performBatchUpdates({
                if self.viewmodel.numberOfFlashCards == 1{
                    self.flashcardSetViewController.collectionView.insertSections(IndexSet(integer: 0))
                    self.flashcardSetViewController.collectionView.insertSections(IndexSet(integer: 1))
                    
                }else{
                    self.viewmodel.isSectionCollapsed() ?
                    self.flashcardSetViewController.collectionView.insertItems(at: [indexPathSetCell,indexPathSmallSetCell]):
                    self.flashcardSetViewController.collectionView.insertItems(at: [indexPathSetCell])
                }
            },completion: { finished in
                if finished{
                    self.flashcardSetViewController.collectionView.layoutIfNeeded()
                    DispatchQueue.main.async {
                        self.flashcardSetViewController.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredHorizontally, animated: false)
                    }
                }
            })
        }
    }
}
