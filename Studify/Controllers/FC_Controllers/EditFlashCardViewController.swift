//
//  EditFlashCardViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/27/24.
//

import Foundation
import UIKit

protocol UpdateFlashCardInSetViewControllerDelegate:AnyObject{
   
    func didUpdateFlashCardInSet(indexPath: IndexPath)
    func didDeleteFlashCardInSet(indexPath:IndexPath)
}
protocol UpdateFlashCardInListViewControllerDelegate:AnyObject{
    
    func didUpdateFlashCardInList(indexPath:IndexPath)
    func didDeleteFlashCardInList(indexPath:IndexPath)
}


final class EditFlashCardViewController: UIViewController{
    let viewmodel: EditFlashCardViewModel
    var flashCardViewModel: FlashcardViewModel
    private let editFlashCardView: EditFlashCardView
    let whichControllerPresented: Int
    let indexPath: IndexPath
    
    weak var flashcardSetViewControllerDelegate: UpdateFlashCardInSetViewControllerDelegate?
    weak var flashcardListViewControllerDelegate: UpdateFlashCardInListViewControllerDelegate?

    
    let navBar: UINavigationBar = {
        
        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    init(flashCardViewModel: FlashcardViewModel, whichControllerPresented: Int, indexPath:IndexPath) {
        
        self.whichControllerPresented = whichControllerPresented
        self.flashCardViewModel = flashCardViewModel
        self.viewmodel = EditFlashCardViewModel(flashcardId: flashCardViewModel.id)
        self.editFlashCardView = EditFlashCardView(frame: .zero, flashcardViewModel: flashCardViewModel)
        self.indexPath = indexPath
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
        view.backgroundColor = viewmodel.backGroundColor
        title = "add new flashcard"
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Details")
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveFlashCard))
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteFlashCard))
        navBar.setItems([navItem], animated: false)
        navBar.backgroundColor = viewmodel.backGroundColor
        navBar.barTintColor = viewmodel.backGroundColor
        view.addSubview(editFlashCardView)
        editFlashCardView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
  
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
        flashCardViewModel.setFrontString(front: editFlashCardView.frontStringTextField.text)
        flashCardViewModel.setBackString(back: editFlashCardView.backStringTextField.text)
        viewmodel.editFlashCard(front: flashCardViewModel.front, back: flashCardViewModel.back)
        updateSectionsInCollection()
        dismiss(animated: true)
    }
    
    func updateSectionsInCollection(){
        whichControllerPresented == 0 ? flashcardSetViewControllerDelegate?.didUpdateFlashCardInSet(indexPath: indexPath) : flashcardListViewControllerDelegate?.didUpdateFlashCardInList(indexPath: indexPath)
    }
    func deleteSectionsInCollection(){
        whichControllerPresented == 0 ? flashcardSetViewControllerDelegate?.didDeleteFlashCardInSet(indexPath: indexPath) : flashcardListViewControllerDelegate?.didDeleteFlashCardInList(indexPath: indexPath)
    }
    @objc
    private func deleteFlashCard(){
        print("delete called")
        let alert = UIAlertController(
            title: "Are you sure you want to delete this flash card?",
            message: "This action cannot be undone",
            preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .default,
                handler: nil
                
            ))
        alert.addAction(
            UIAlertAction(
                title: "Delete Flashcard",
                style: .destructive,
                handler: {[weak self] UIAlertAction in
                    
                    self?.viewmodel.deleteFlashCard()
                    self?.deleteSectionsInCollection()
                    self?.dismiss(animated: true)
                }
            ))
        present(alert, animated: true)
    }
}
