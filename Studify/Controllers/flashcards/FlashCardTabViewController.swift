//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit

final class FlashCardTabViewController:UITabBarController {
    let viewmodel:FlashcardSetViewModel
    
    init(topicID:UUID){
        self.viewmodel = FlashcardSetViewModel(topicID: topicID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setupTabs()
    }
}

extension FlashCardTabViewController{
    
    private func setupTabs(){
        let flashcardSetViewController = FlashCardSetViewController(viewmodel: viewmodel)
        let flashcardListViewController = FlashCardListViewController(viewmodel: viewmodel)
        
        let nav1 = UINavigationController(rootViewController: flashcardSetViewController)
        let nav2 = UINavigationController(rootViewController: flashcardListViewController)
        
        nav1.navigationBar.prefersLargeTitles = false
        nav2.navigationBar.prefersLargeTitles = false
        
        nav1.tabBarItem = UITabBarItem(title: "set",image: UIImage(systemName: "menucard"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "list", image:UIImage(systemName: "list.bullet"), tag: 2)
        
        setViewControllers(
            [nav1, nav2],
            animated: true
        )
    }
}
