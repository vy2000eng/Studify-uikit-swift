//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit

final class FlashCardTabViewController:UITabBarController {
    
    let viewmodel:FlashcardSetViewModel
    let topicIndexPath: IndexPath
    
    init(topicID:UUID, topicIndexPath: IndexPath){
        self.viewmodel = FlashcardSetViewModel(topicID: topicID)
        self.topicIndexPath = topicIndexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
    }
}




