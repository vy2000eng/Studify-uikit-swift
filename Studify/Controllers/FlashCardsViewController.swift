//
//  FlashCardsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/8/24.
//

import UIKit

class FlashCardSetViewController: UIViewController {
    
    let viewModel:FlashcardSetViewModel
    
    init(topicID:UUID){
        self.viewModel = FlashcardSetViewModel(topicID: topicID)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "hello"
        label.backgroundColor = UIColor.systemBlue
        
        
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        setupConstraints()

        // Do any additional setup after loading the view.
    }
    
    


}

extension FlashCardSetViewController{
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
}
