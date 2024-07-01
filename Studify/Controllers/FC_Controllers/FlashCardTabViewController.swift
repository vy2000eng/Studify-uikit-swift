//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit

final class FlashCardTabViewController:UITabBarController, AddFlashCardToListViewCollectionDelegate, AddFlashCardToSetViewCollectionDelegate, UpdateFlashCardInFlashCardListViewControllerCollectionViewDelegate, UpdateFlashCardInFlashCardSetViewControllerCollectionViewDelegate{
  

    let viewmodel:FlashcardSetViewModel
    let topicIndexPath: IndexPath
    
    let flashcardSetViewController: FlashCardSetViewController
    let flashcardListViewController: FlashCardListViewController
    let nav1: UINavigationController
    let nav2: UINavigationController

    init(topicID:UUID, topicIndexPath: IndexPath){
        self.viewmodel = FlashcardSetViewModel(topicID: topicID)
        self.topicIndexPath = topicIndexPath
        self.flashcardSetViewController = FlashCardSetViewController(viewmodel: viewmodel, topicIndexPath: topicIndexPath)
        self.flashcardListViewController = FlashCardListViewController(viewmodel: viewmodel, topicIndexPath: topicIndexPath)
        self.nav1 = UINavigationController(rootViewController: flashcardSetViewController)
        self.nav2 = UINavigationController(rootViewController: flashcardListViewController)
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        print("tabview loaded")
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemBackground
        setup()
    }
}

extension FlashCardTabViewController{
    private func setup(){
        nav1.navigationBar.prefersLargeTitles = false
        nav2.navigationBar.prefersLargeTitles = false
        flashcardSetViewController.addFlashCardInListViewControllerDelegate = self
        flashcardListViewController.addFlashCardInSetViewControllerDelegate = self
        flashcardSetViewController.updateFlashCardInListViewControllerDelegate = self
        flashcardListViewController.updateFlashCardInSetViewControllerDelegate = self
        
        nav1.tabBarItem = UITabBarItem(title: "set",image: UIImage(systemName: "menucard"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "list", image:UIImage(systemName: "list.bullet"), tag: 2)
        
        setViewControllers(
            [nav1, nav2],
            animated: true
        )
    }
}


extension FlashCardTabViewController{
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
    //MARK ADD
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
        print("SHOULD NOT BE CALLED HERE 2")
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
    
    
//    func didDeleteFlashCardInListViewControllerFromSetViewController(indexPath: IndexPath) {
//        if flashcardListViewController.isViewLoaded{
//            didDeleteFlashCardInList(indexPath: indexPath)
//        }
//    }
}


extension FlashCardTabViewController{
    //MARK: DELETE
    func didDeleteFlashCardInList(indexPath: IndexPath, newIndexPathForList: IndexPath){

        print("delete Flashcard called in list vc")
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
        print("delete Flashcard called in set vc")
        viewmodel.getAllFlashcards()
        //were using this to delete the item, that is in fact deleted, but still in the list via the ui
        let indexPathSetCell = IndexPath(row:indexPath.row, section: 0)
        let indexPathSmallSetCell = IndexPath(row: indexPath.row, section: 1)
        
        DispatchQueue.main.async {
            self.flashcardSetViewController.collectionView.performBatchUpdates({
                self.flashcardSetViewController.collectionView.deleteItems(at: [indexPathSetCell,indexPathSmallSetCell])

            },completion: { finished in
                if finished{

                    self.flashcardSetViewController.collectionView.layoutIfNeeded()
                    
                    DispatchQueue.main.async {
                        if self.viewmodel.numberOfFlashCards > 0 {
                            // were using this to delete scroll to the new item that was determined in
                            let updatedIndexPathSetCell = IndexPath(row: self.viewmodel.currentIndex, section: 0)
                            let updatedIndexPathSmallSetCell = IndexPath(row: self.viewmodel.currentIndex, section: 1)
                            // Scroll both sections
                            self.flashcardSetViewController.collectionView.scrollToItem(at: updatedIndexPathSetCell, at: .centeredHorizontally, animated: false)
                            self.flashcardSetViewController.collectionView.scrollToItem(at: updatedIndexPathSmallSetCell, at: .centeredHorizontally, animated: false)
                            // Optionally, select the item in the small set
                            self.flashcardSetViewController.collectionView.selectItem(at: updatedIndexPathSmallSetCell, animated: false, scrollPosition: .centeredHorizontally)
                        }
                    }
                }
            })
        }
    }
    //MARK: UPDATE
    func didUpdateFlashCardInList(indexPath:IndexPath){
        print("updateFlashcard called in list vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: indexPath.row, section: 0)
        
        DispatchQueue.main.async {
            self.flashcardListViewController.collectionView.performBatchUpdates({
                self.flashcardListViewController.collectionView.reloadItems(at: [indexPathSetCell])
            },completion: {finished in
                if finished{
                    self.flashcardListViewController.collectionView.scrollToItem(at: indexPathSetCell, at: .bottom, animated: false)
                }
                
            })
        }
    }
    
    func didUpdateFlashCardInSet(indexPath:IndexPath){
        print("add Flashcard called in set vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row:self.viewmodel.currentIndex, section: 0)
        let indexPathSmallSetCell = IndexPath(row: self.viewmodel.currentIndex, section: 1)
        
        
        DispatchQueue.main.async {
            self.flashcardSetViewController.collectionView.performBatchUpdates({
                self.flashcardSetViewController.collectionView.reloadItems(at: [indexPathSetCell,indexPathSmallSetCell])
            },completion: { finished in
                if finished{
                    self.flashcardSetViewController.collectionView.layoutIfNeeded()
                    DispatchQueue.main.async {
                        
                        self.flashcardSetViewController.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredHorizontally, animated: false)
                        self.flashcardSetViewController.collectionView.scrollToItem(at: indexPathSmallSetCell, at: .centeredHorizontally, animated: false)
                    }
                }
                
            })
        }
    }
    
    //MARK: ADD
    func didAddFlashcardToList() {
        print("add Flashcard called in list vc")
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
        print("add Flashcard called in set vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 0)
        let indexPathSmallSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 1)
        DispatchQueue.main.async {
            self.flashcardSetViewController.collectionView.performBatchUpdates({
                self.flashcardSetViewController.collectionView.insertItems(at: [indexPathSetCell,indexPathSmallSetCell])
              
            },completion: { finished in
                if finished{
                    self.flashcardSetViewController.collectionView.layoutIfNeeded()
                    DispatchQueue.main.async {
                        self.flashcardSetViewController.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredHorizontally, animated: false)
                        self.flashcardSetViewController.collectionView.scrollToItem(at: indexPathSmallSetCell, at: .centeredHorizontally, animated: false)
                    }
                }
            })
        }
    }
}




