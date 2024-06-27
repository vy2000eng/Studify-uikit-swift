//
//  EditFlashCardViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/27/24.
//

import Foundation
import UIKit
final class EditFlashCardViewController: UIViewController{
    let viewmodel: EditFlashCardViewModel
    let flashCardViewModel: FlashcardViewModel
    private let editFlashCardView: EditFlashCardView
    
    let navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    init(flashCardViewModel: FlashcardViewModel) {
        self.flashCardViewModel = flashCardViewModel
        self.viewmodel = EditFlashCardViewModel(flashcardId: flashCardViewModel.id)
        self.editFlashCardView = EditFlashCardView(frame: .zero, flashcardViewModel: flashCardViewModel)
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

        setupView()
    }
  
    
    
    
}

extension EditFlashCardViewController{
    private func setupView(){
        view.backgroundColor = UIColor.systemBackground
        title = "add new flashcard"
        //let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Details")
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveFlashCard))
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteFlashCard))
        navBar.setItems([navItem], animated: false)

        view.addSubview(editFlashCardView)

        editFlashCardView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        
        
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //navBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           // navBar.heightAnchor.constraint(equalTo:44 ),// ensure it's constrained to the bottom if you want it to fill the screen
            
            editFlashCardView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 10),
            editFlashCardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            editFlashCardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            editFlashCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // ensure it's constrained to the bottom if you want it to fill the screen
            
        ])
    }
}

extension EditFlashCardViewController{
    @objc
    private func saveFlashCard(){
        print("save called")
        
    }
    
    @objc
    private func deleteFlashCard(){
        print("delete called")
        
    }
}
