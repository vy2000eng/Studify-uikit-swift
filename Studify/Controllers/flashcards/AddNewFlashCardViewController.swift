//
//  addNewFlashCardViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit


class AddNewFlashCardViewController: UIViewController{
    
    private let addFlashCardView = addNewFlashCardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}
extension AddNewFlashCardViewController{
    private func setupView(){
        view.backgroundColor = UIColor.systemBackground
        title = "add new flashcard"
        view.addSubview(addFlashCardView)
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveFlashCard))
        addFlashCardView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            addFlashCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addFlashCardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            addFlashCardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addFlashCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // ensure it's constrained to the bottom if you want it to fill the screen
        ])
    }
}

extension AddNewFlashCardViewController{
    @objc
    private func saveFlashCard(){
        
    }
}
