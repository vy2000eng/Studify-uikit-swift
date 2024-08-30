//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit
import Foundation
import NotificationBannerSwift

//MARK: These delegates are inside of FlashCardsCollectionsManager
final class FlashCardTabViewController:UITabBarController, AddFlashCardToListViewCollectionDelegate, AddFlashCardToSetViewCollectionDelegate, UpdateFlashCardInFlashCardListViewControllerCollectionViewDelegate, UpdateFlashCardInFlashCardSetViewControllerCollectionViewDelegate{
  
    let viewmodel:FlashcardSetViewModel
    let topicIndexPath: IndexPath
    let flashcardSetViewController: FlashCardSetViewController
    let flashcardListViewController: FlashCardListViewController
    let topicID: UUID

    init(topicID:UUID, topicIndexPath: IndexPath){
        self.topicID = topicID
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
        NotificationCenter.default.addObserver(self, selector: #selector(applyTheme), name: .themeDidChange, object: nil)

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = viewmodel.sectionTitle.type.title // This will be your initial large title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: viewmodel.fontColor,
                                                                   .font:viewmodel.subtitleFont ]

        view.backgroundColor = viewmodel.background
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewmodel.viewControllerCurrentlyAppearing == 0 ?
        self.flashcardSetViewController.delegate?.didUpdateNumberOfFlashcardsFromFlashCardSetViewController(indexPath: topicIndexPath) :
        self.flashcardListViewController.delegate?.didUpdateNumberOfFlashcardsFromFlashCardListViewController(indexPath: topicIndexPath)
    }

    deinit {
          NotificationCenter.default.removeObserver(self)
      }
}

extension FlashCardTabViewController{
    @objc
    func applyTheme(){
        view.backgroundColor = viewmodel.background
        tabBar.backgroundColor = viewmodel.background
         tabBar.barTintColor = viewmodel.background
         tabBar.isTranslucent = false
        
        flashcardSetViewController.view.backgroundColor = viewmodel.background
        flashcardListViewController.view.backgroundColor = viewmodel.background
    }
    
  
    private func setup(){
        
        navigationItem.rightBarButtonItem = createOptionsBarButtonItem()
        flashcardSetViewController.addFlashCardInListViewControllerDelegate = self
        flashcardListViewController.addFlashCardInSetViewControllerDelegate = self
        flashcardSetViewController.updateFlashCardInListViewControllerDelegate = self
        flashcardListViewController.updateFlashCardInSetViewControllerDelegate = self
        flashcardSetViewController.tabBarItem = UITabBarItem(title: "Set", image: UIImage(systemName: "menucard"), tag: 1)
        flashcardListViewController.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet"), tag: 2)
        setViewControllers(  [flashcardSetViewController,flashcardListViewController], animated: true)
        
        view.backgroundColor = viewmodel.background
        tabBar.backgroundColor = viewmodel.background
        tabBar.barTintColor = viewmodel.background
        tabBar.isTranslucent = false
        delegate = self
    }
}

extension FlashCardTabViewController{
    
    private func animateReloadingCollectionView(){
        let listCollectionView = flashcardListViewController.collectionView
        let setCollectionView = flashcardSetViewController.collectionView
        
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else {return}
            
            switch viewmodel.viewControllerCurrentlyAppearing{
                
            case 0:
                UIView.transition(with:  setCollectionView, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
                    guard let self = self else{
                        return
                    }
                    setCollectionView.reloadData()
                    
                }, completion: {finished in
                    listCollectionView.reloadData()
                })
                
                break
            case 1:
                UIView.transition(with:  listCollectionView, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
                    guard let self = self else{
                        return
                    }
                    listCollectionView.reloadData()
                    
                }, completion: {finished in
                    setCollectionView.reloadData()

                    
                })
                break
                
            default:
                fatalError("couldnt reload data")
            }

        }
        
    }
    
    func createOptionsBarButtonItem() -> UIBarButtonItem{
    
        let addFlashCardAction = UIAction(title: "add flashcard") { [weak self] _ in
            
            guard let self = self else { return }

            
            let vc = AddNewFlashCardViewController(flashcardSetViewModel: self.viewmodel , whichControllerPushed: self.viewmodel.viewControllerCurrentlyAppearing)
            
            if self.viewmodel.viewControllerCurrentlyAppearing == 0{
                vc.flashCardSetViewControllerDelegate = self.flashcardSetViewController
            }else{
                vc.flashCardListViewControllerDelegate = self.flashcardListViewController
            }
            let addFlashCardNavigationController = UINavigationController(rootViewController: vc)
            present(addFlashCardNavigationController, animated: true)
            
        }
        
        let banner = NotificationBanner(title: "Notice!",subtitle: "", style: .info)
        banner.dismissOnSwipeUp = true
        banner.dismissOnTap = true
        banner.duration = 2.5
        
        let filterLearnedAction = UIAction(title: "learned", image: UIImage(systemName: "doc")){[weak self] _ in
            guard let self = self else {return}
            viewmodel.sectionTitle = .learnedFlashCards
            title = viewmodel.sectionTitle.type.title
            viewmodel.getLearnedFlashcards()
            animateReloadingCollectionView()
            banner.subtitleLabel?.text = "The flashcards are only the ones you have learned"
            banner.show(bannerPosition: .top)
        }
        
        let filterUnlearnedAction = UIAction(title: "still learning", image: UIImage(systemName: "doc")){ [weak self] _ in
            guard let self = self else {return}
            viewmodel.sectionTitle = .stillLearningFlashCards
            title = viewmodel.sectionTitle.type.title
            viewmodel.getStillLearningFlashcards()
            animateReloadingCollectionView()
            banner.subtitleLabel?.text = "The flashcards are only the ones you are still learning"
            banner.show(bannerPosition: .top)
        }
        
        let filterAllAction = UIAction(title: "all",image: UIImage(systemName: "doc")){ [weak self]_ in
            guard let self = self else {return}
            viewmodel.sectionTitle = .allFlashCards
            title = viewmodel.sectionTitle.type.title

            viewmodel.getAllFlashcardsForListSet()
            animateReloadingCollectionView()
            banner.subtitleLabel?.text = "The flashcards are all the flashcards"
            banner.show(bannerPosition: .top)
    
        }
        let studyAction = UIAction(title:"study",image: UIImage(systemName: "graduationcap")){[weak self] _ in
            guard let self = self else {return}
            
            
        }

        let menu = UIMenu(title: "options", children: [addFlashCardAction ,filterLearnedAction, filterUnlearnedAction, filterAllAction, studyAction])
        return UIBarButtonItem(image: UIImage(systemName: "ellipsis"), menu: menu)
        
    }

}


//TODO: we dont need some of this code regarding changing the title
extension FlashCardTabViewController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        navigationItem.rightBarButtonItem
//        = viewmodel.viewControllerCurrentlyAppearing == 2
//        ? nil
//        : createOptionsBarButtonItem()
//
//
//            
//        
//        viewController.navigationController?.navigationBar.prefersLargeTitles = true
//        viewController.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: viewmodel.fontColor,
//                                                                        .font: viewmodel.titleFont]
//        navigationItem.largeTitleDisplayMode = .always
//
//        
//        
//        title 
//        = viewmodel.viewControllerCurrentlyAppearing == 2
//        ? "Game"
//        : viewmodel.sectionTitle.type.title
//
//        
//    }
}
