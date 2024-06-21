//
//  FlashCardListViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit

class FlashCardListViewController: UIViewController{
    let viewmodel: FlashcardSetViewModel
    
    init(viewmodel: FlashcardSetViewModel) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var label:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "flashcardListViewController"
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

extension FlashCardListViewController{
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    
    
}


