//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit
import Foundation

final class FlashCardTabViewController:UITabBarController, AddFlashCardToListViewCollectionDelegate, AddFlashCardToSetViewCollectionDelegate, UpdateFlashCardInFlashCardListViewControllerCollectionViewDelegate, UpdateFlashCardInFlashCardSetViewControllerCollectionViewDelegate{
  

    let viewmodel:FlashcardSetViewModel
    let topicIndexPath: IndexPath
    
    let flashcardSetViewController: FlashCardSetViewController
    let flashcardListViewController: FlashCardListViewController
//    let nav1: UINavigationController
//    let nav2: UINavigationController


    init(topicID:UUID, topicIndexPath: IndexPath){
        self.viewmodel = FlashcardSetViewModel(topicID: topicID)
        self.topicIndexPath = topicIndexPath
        self.flashcardSetViewController = FlashCardSetViewController(viewmodel: viewmodel, topicIndexPath: topicIndexPath)
        self.flashcardListViewController = FlashCardListViewController(viewmodel: viewmodel, topicIndexPath: topicIndexPath)
//        self.nav1 = UINavigationController(rootViewController: flashcardSetViewController)
//        self.nav2 = UINavigationController(rootViewController: flashcardListViewController)
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemBackground
        setup()
    }
}

extension FlashCardTabViewController{

    
    private func setup(){
        
        navigationItem.rightBarButtonItem = createOptionsBarButtonItem()
        navigationItem.leftBarButtonItem = closeBarButtonItem()
//        nav1.navigationBar.prefersLargeTitles = false
//        nav2.navigationBar.prefersLargeTitles = false
        
        flashcardSetViewController.addFlashCardInListViewControllerDelegate = self
        flashcardListViewController.addFlashCardInSetViewControllerDelegate = self
        flashcardSetViewController.updateFlashCardInListViewControllerDelegate = self
        flashcardListViewController.updateFlashCardInSetViewControllerDelegate = self
        
//        nav1.tabBarItem = UITabBarItem(title: "set",image: UIImage(systemName: "menucard"), tag: 1)
//        nav2.tabBarItem = UITabBarItem(title: "list", image:UIImage(systemName: "list.bullet"), tag: 2)
        flashcardSetViewController.tabBarItem = UITabBarItem(title: "Set", image: UIImage(systemName: "menucard"), tag: 1)
           flashcardListViewController.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet"), tag: 2)
        setViewControllers(
            [flashcardSetViewController,flashcardListViewController],
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
                           // let updatedIndexPathSmallSetCell = IndexPath(row: self.viewmodel.currentIndex, section: 1)
                            // Scroll both sections
                            self.flashcardSetViewController.collectionView.scrollToItem(at: updatedIndexPathSetCell, at: .centeredHorizontally, animated: false)
                           // self.flashcardSetViewController.collectionView.scrollToItem(at: updatedIndexPathSmallSetCell, at: .centeredHorizontally, animated: false)
                            // Optionally, select the item in the small set
                            //self.flashcardSetViewController.collectionView.selectItem(at: updatedIndexPathSmallSetCell, animated: false, scrollPosition: .centeredHorizontally)
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
                       // self.flashcardSetViewController.collectionView.scrollToItem(at: indexPathSmallSetCell, at: .centeredHorizontally, animated: false)
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

extension FlashCardTabViewController{
    
    func createOptionsBarButtonItem() -> UIBarButtonItem{
        let addFlashCardAction = UIAction(title: "add flashcard") { [weak self] _ in
            
            guard let self = self else { return }

            
            let vc = AddNewFlashCardViewController(flashcardSetViewModel: self.viewmodel , whichControllerPushed: self.viewmodel.viewControllerCurrentlyAppearing)
            // MARK: This delegate is for adding a flashcard to only the collection view defined in this viewcontroller.
            // The protocol for this delegate is defined in AddNewFlashCardViewController.
            // That is a fact. I know it might seem obvious, but I hope this help future you.
            // MARK: "flashCardListViewControllerDelegate" is defined in "AddNewFlashCardViewController"
            
            if self.viewmodel.viewControllerCurrentlyAppearing == 0{
                vc.flashCardSetViewControllerDelegate = self.flashcardSetViewController
            }else{
                vc.flashCardListViewControllerDelegate = self.flashcardListViewController
            }
            let addFlashCardNavigationController = UINavigationController(rootViewController: vc)
            present(addFlashCardNavigationController, animated: true)
           // vc.flashCardSetViewControllerDelegate = self.viewmodel.viewControllerCurrentlyAppearing == 0 ?  flashcardSetViewController as? FlashCardSetViewController: flashcardListViewController as? FlashCardListViewController
           // self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        let filterLearnedAction = UIAction(title: "learned flashcards"){ _ in
            
        }
        
        let filterUnlearnedAction = UIAction(title: "unlearned flashcards"){ _ in
            
        }
        
        let filterAllAction = UIAction(title: "all flashcards"){ _ in
            
        }

        let menu = UIMenu(title: "options", children: [addFlashCardAction ,filterLearnedAction, filterUnlearnedAction, filterAllAction])
        
        return UIBarButtonItem(image: UIImage(systemName: "ellipsis"), menu: menu)
        
        
    }
    
    func closeBarButtonItem() -> UIBarButtonItem{
        
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"))
        barButtonItem.target = self
        barButtonItem.action = #selector(closeViewController)
     
        return barButtonItem
        
        
    }
    
    @objc
    private func closeViewController(){
        
        if viewmodel.viewControllerCurrentlyAppearing == 0 {
            self.flashcardSetViewController.delegate?.didUpdateNumberOfFlashcardsFromFlashCardSetViewController(indexPath: topicIndexPath)
        }else{
            self.flashcardListViewController.delegate?.didUpdateNumberOfFlashcardsFromFlashCardListViewController(indexPath: topicIndexPath)
            //self.flashcardListViewController.delegate?.didUpdateNumberOfFlashcardsFromFlashCardSetViewController(indexPath: topicIndexPath)

            
        }
        dismiss(animated: true)
        
    }
    

    
}




