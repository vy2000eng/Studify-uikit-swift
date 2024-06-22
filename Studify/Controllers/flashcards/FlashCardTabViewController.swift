//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit

class FlashCardTabViewController:UITabBarController {
    let viewmodel:FlashcardSetViewModel
    
    init(topicID:UUID){
        self.viewmodel = FlashcardSetViewModel(topicID: topicID)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        view.backgroundColor = UIColor.systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewFlashCard))
        
        
        super.viewDidLoad()
        setupTabs()

    }


}

extension FlashCardTabViewController{
    
    
    private func setupTabs(){
        let flashcardSetViewController = FlashCardSetViewController(viewmodel: viewmodel)
        let flashcardListViewController = FlashCardListViewController(viewmodel: viewmodel)
        flashcardSetViewController.navigationItem.largeTitleDisplayMode = .automatic
        flashcardListViewController.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: flashcardSetViewController)
        let nav2 = UINavigationController(rootViewController: flashcardListViewController)
        
        nav1.tabBarItem = UITabBarItem(title: "set",image: UIImage(systemName: "menucard"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "list", image:UIImage(systemName: "list.bullet"), tag: 2)
        
        for nav in [nav1, nav2] {
                   nav.navigationBar.prefersLargeTitles = true
               }
        
        setViewControllers(
                 [nav1, nav2],
                 animated: true
             )
    }
}

extension FlashCardTabViewController{
    
    @objc
    private func addNewFlashCard(){
        let vc = AddNewFlashCardViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
