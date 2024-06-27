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
       // flashcardSetViewController.addFlashCardInSetViewControllerDelegate = self
       // flashcardListViewController.addFlashCardInListViewControllerDelegate = self
        
        nav1.tabBarItem = UITabBarItem(title: "set",image: UIImage(systemName: "menucard"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "list", image:UIImage(systemName: "list.bullet"), tag: 2)
        
        setViewControllers(
            [nav1, nav2],
            animated: true
        )
    }
}
extension FlashCardTabViewController{

    func didAddFlashCardToSetViewControllerFromListViewController() {
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
        if flashcardSetViewController.isViewLoaded{
            didAddFlashcardToSet()
            
        }
    }
    
    func didAddFlashCardInListViewControllerFromSetViewController() {
        if flashcardListViewController.isViewLoaded{
            didAddFlashcardToList()
            
        }
        
    }
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
    
    
    
    func didUpdateFlashCardInList(indexPath:IndexPath){
        print("updateFlashcard called in list vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: indexPath.row, section: 0)
        
        DispatchQueue.main.async {
            self.flashcardListViewController.collectionView.performBatchUpdates({
                self.flashcardListViewController.collectionView.reloadItems(at: [indexPathSetCell])
            })
        }
        
    }
    
    func didUpdateFlashCardInSet(indexPath:IndexPath){
        print("add Flashcard called in set vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row:indexPath.row, section: 0)
        let indexPathSmallSetCell = IndexPath(row: indexPath.row, section: 1)
        
        DispatchQueue.main.async {
            self.flashcardSetViewController.collectionView.performBatchUpdates({
                self.flashcardSetViewController.collectionView.reloadItems(at: [indexPathSetCell])
                self.flashcardSetViewController.collectionView.reloadItems(at: [indexPathSmallSetCell])
            })
        }
        
    }
   
    
    func didAddFlashcardToList() {
        print("add Flashcard called in list vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 0)
        
        DispatchQueue.main.async {
            self.flashcardListViewController.collectionView.performBatchUpdates({
                self.flashcardListViewController.collectionView.insertItems(at: [indexPathSetCell])
            })
        }
    }
    
    func didAddFlashcardToSet() {
        print("add Flashcard called in set vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 0)
        let indexPathSmallSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 1)
        
        DispatchQueue.main.async {
            self.flashcardSetViewController.collectionView.performBatchUpdates({
                self.flashcardSetViewController.collectionView.insertItems(at: [indexPathSetCell])
                self.flashcardSetViewController.collectionView.insertItems(at: [indexPathSmallSetCell])
            })
        }
    }
}






