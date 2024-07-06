//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit
import Foundation

//MARK: These delegates are inside of FlashCardsCollectionsManager
final class FlashCardTabViewController:UITabBarController, AddFlashCardToListViewCollectionDelegate, AddFlashCardToSetViewCollectionDelegate, UpdateFlashCardInFlashCardListViewControllerCollectionViewDelegate, UpdateFlashCardInFlashCardSetViewControllerCollectionViewDelegate{
  
    let viewmodel:FlashcardSetViewModel
    let topicIndexPath: IndexPath
    
    let flashcardSetViewController: FlashCardSetViewController
    let flashcardListViewController: FlashCardListViewController

    init(topicID:UUID, topicIndexPath: IndexPath){
        self.viewmodel = FlashcardSetViewModel(topicID: topicID)
        self.topicIndexPath = topicIndexPath
        self.flashcardSetViewController = FlashCardSetViewController(viewmodel: viewmodel, topicIndexPath: topicIndexPath)
        self.flashcardListViewController = FlashCardListViewController(viewmodel: viewmodel, topicIndexPath: topicIndexPath)

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
        
        flashcardSetViewController.addFlashCardInListViewControllerDelegate = self
        flashcardListViewController.addFlashCardInSetViewControllerDelegate = self
        flashcardSetViewController.updateFlashCardInListViewControllerDelegate = self
        flashcardListViewController.updateFlashCardInSetViewControllerDelegate = self
        
        flashcardSetViewController.tabBarItem = UITabBarItem(title: "Set", image: UIImage(systemName: "menucard"), tag: 1)
        flashcardListViewController.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet"), tag: 2)
        setViewControllers(  [flashcardSetViewController,flashcardListViewController], animated: true)
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
        
        viewmodel.viewControllerCurrentlyAppearing == 0 ?
        self.flashcardSetViewController.delegate?.didUpdateNumberOfFlashcardsFromFlashCardSetViewController(indexPath: topicIndexPath) :
        self.flashcardListViewController.delegate?.didUpdateNumberOfFlashcardsFromFlashCardListViewController(indexPath: topicIndexPath)
        dismiss(animated: true)
    }
}




