//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit

final class FlashCardTabViewController:UITabBarController, UpdateFlashCardInListViewDelegate, UpdateFlashCardInSetViewControllerDelegate{
 
    
   
    

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
    
   // let flashcardSetViewController = FlashCardSetViewController(viewmodel: viewmodel, topicIndexPath: topicIndexPath)
   // let flashcardListViewController = FlashCardListViewController(viewmodel: viewmodel, topicIndexPath: topicIndexPath)
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        print("tabview loaded")
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemBackground
        setup()
     
        

        // setupCloseButton()
    }
}

extension FlashCardTabViewController{
    private func setup(){
       // let nav1 = UINavigationController(rootViewController: flashcardSetViewController)
       // let nav2 = UINavigationController(rootViewController: flashcardListViewController)
        
        nav1.navigationBar.prefersLargeTitles = false
        nav2.navigationBar.prefersLargeTitles = false
        flashcardSetViewController.updateFlashCardInListViewControllerDelegate = self
        flashcardListViewController.updateFlashCardInSetViewControllerDelegate = self
//        viewmodel.flashCardListViewControllerDelegate = self
//        viewmodel.flashCardSetViewControllerDelegate = self
        
        nav1.tabBarItem = UITabBarItem(title: "set",image: UIImage(systemName: "menucard"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "list", image:UIImage(systemName: "list.bullet"), tag: 2)
        
        setViewControllers(
            [nav1, nav2],
            animated: true
        )
        
        
    }
}
extension FlashCardTabViewController{
    func updateFlashCardInListViewControllerFromSetViewController() {
        if flashcardListViewController.isViewLoaded{
            didAddFlashcardToList()
            
        }
    }
    func updateFlashCardInSetViewControllerFromListViewController() {
        if flashcardSetViewController.isViewLoaded{
            didAddFlashcardToSet()
            
        }
    }
    
    
    
    
    func didAddFlashcardToList() {
        print("updateFlashcard called in list vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 0)
        let indexPathSmallSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 1)
        
        //let indexPathSmallSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 1)
        // self.flashcardListViewController.collectionView.reloadData()
        
        
        DispatchQueue.main.async {
            self.flashcardListViewController.collectionView.performBatchUpdates({
                self.flashcardListViewController.collectionView.insertItems(at: [indexPathSetCell])
                
            }
                                                                                
            )
        }
        
    }
    
    
    
    
    func didAddFlashcardToSet() {
        print("updateFlashcard called in set vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 0)
        let indexPathSmallSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 1)
        DispatchQueue.main.async {
            self.flashcardSetViewController.collectionView.performBatchUpdates({
                //  self.flashcardListViewController.collectionView.insertItems(at: [indexPathListCell])
                
                self.flashcardSetViewController.collectionView.insertItems(at: [indexPathSetCell])
                self.flashcardSetViewController.collectionView.insertItems(at: [indexPathSmallSetCell])
                
                
                // self.flashcardListViewController.collectionView.scrollToItem(at: indexPathListCell, at: .bottom, animated: true)
                
                
            }
                                                                               //                    ,completion: { finished in
                                                                               //                    if finished {
                                                                               //                        self.flashcardSetViewController.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredHorizontally, animated: true)
                                                                               //                        self.flashcardSetViewController.collectionView.scrollToItem(at: indexPathSmallSetCell, at: .centeredHorizontally, animated: true)
                                                                               //                        //self.flashcardListViewController.collectionView.insertItems(at: [indexPathSetCell])
                                                                               //    
                                                                               //                        //self.flashcardListViewController.collectionView.inse(at: indexPathSetCell, at: .bottom, animated: true)
                                                                               //    
                                                                               //                    }
                                                                               //    
                                                                               //                }
            )
        }
        
        
        
    }
    
    
    
}


//extension FlashCardTabViewController{
//    func updateFlashCardInFlashCardSetViewController(){
//        didAddFlashcardToSet()
//    }
//    
//    func updateFlashCardInFlashCardListViewController(){
//        didAddFlashcardToList()
//        
//    }
//    
//    
//    func didAddFlashcardToList() {
//        print("updateFlashcard called in list vc")
//        viewmodel.getAllFlashcards()
//        let indexPathSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 0)
//        let indexPathSmallSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 1)
//        
//        //let indexPathSmallSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 1)
//        // self.flashcardListViewController.collectionView.reloadData()
//        
//        
//        DispatchQueue.main.async {
//            self.flashcardListViewController.collectionView.performBatchUpdates({
//                self.flashcardListViewController.collectionView.insertItems(at: [indexPathSetCell])
//                
//            }
//                                                                                ,completion: { finished in
//                if finished {
//                    self.flashcardListViewController.collectionView.scrollToItem(at: indexPathSetCell, at: .bottom, animated: true)
//                    
//                }
//            }
//            )
//        }
//        DispatchQueue.main.async {
//            self.flashcardSetViewController.collectionView.performBatchUpdates({
//                //  self.flashcardListViewController.collectionView.insertItems(at: [indexPathListCell])
//                
//                self.flashcardSetViewController.collectionView.insertItems(at: [indexPathSetCell])
//                self.flashcardSetViewController.collectionView.insertItems(at: [indexPathSmallSetCell])
//                
//                
//                // self.flashcardListViewController.collectionView.scrollToItem(at: indexPathListCell, at: .bottom, animated: true)
//                
//                
//            })
//            
//            
//        }
//    }
    
//    func didAddFlashcardToSet() {
//        print("updateFlashcard called in set vc")
//        viewmodel.getAllFlashcards()
//        let indexPathSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 0)
//        let indexPathSmallSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 1)
//        DispatchQueue.main.async {
//            self.flashcardSetViewController.collectionView.performBatchUpdates({
//          //  self.flashcardListViewController.collectionView.insertItems(at: [indexPathListCell])
//
//              self.flashcardSetViewController.collectionView.insertItems(at: [indexPathSetCell])
//              self.flashcardSetViewController.collectionView.insertItems(at: [indexPathSmallSetCell])
//
//
//                // self.flashcardListViewController.collectionView.scrollToItem(at: indexPathListCell, at: .bottom, animated: true)
//
//                
//            }
//                ,completion: { finished in
//                if finished {
//                    self.flashcardSetViewController.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredHorizontally, animated: true)
//                    self.flashcardSetViewController.collectionView.scrollToItem(at: indexPathSmallSetCell, at: .centeredHorizontally, animated: true)
//                    //self.flashcardListViewController.collectionView.insertItems(at: [indexPathSetCell])
//
//                    //self.flashcardListViewController.collectionView.inse(at: indexPathSetCell, at: .bottom, animated: true)
//
//                }
//                
//            }
//            )
//        }
//
//
//
//    }
//}






