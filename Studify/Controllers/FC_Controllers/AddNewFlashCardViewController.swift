//
//  addNewFlashCardViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit
//TODO: Add commments for the love of god!
protocol AddNewFlashCardToSetViewControllerDelegate: AnyObject{
    func didAddFlashcardToSet()
}

//TODO: Add commments for the love of god!
protocol AddNewFlashCardToListViewControllerDelegate: AnyObject{
    func didAddFlashcardToList()
}

class AddNewFlashCardViewController: UIViewController{
    
    private let addFlashCardView = AddNewFlashCardView()
    let viewmodel: AddNewFlashCardViewModel
    let flashcardSetViewModel: FlashcardSetViewModel
    let whichControllerPushed: Int
    
    weak var flashCardSetViewControllerDelegate: AddNewFlashCardToSetViewControllerDelegate?
    weak var flashCardListViewControllerDelegate: AddNewFlashCardToListViewControllerDelegate?
    
    init(flashcardSetViewModel: FlashcardSetViewModel, whichControllerPushed: Int){
       
        self.whichControllerPushed = whichControllerPushed
        self.flashcardSetViewModel = flashcardSetViewModel
        self.viewmodel = AddNewFlashCardViewModel(topicID: flashcardSetViewModel.topicID)
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
        guard let frontString = addFlashCardView.frontStringTextField.text , !addFlashCardView.frontStringTextField.text.isEmpty
        else{
            let alert = UIAlertController(
                title: "Error",
                message: "front string can't be empty",
                preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "Ok",
                    style: .default))
            present(alert, animated: true)
            return
        }
        
        guard let backString = addFlashCardView.backStringTextField.text , !addFlashCardView.backStringTextField.text.isEmpty
        else{
            let alert = UIAlertController(
                title: "Error",
                message: "back string can't be empty",
                preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "Ok",
                    style: .default))
            present(alert, animated: true)
            return
        }
        viewmodel.addFlashcard(front: frontString, back: backString)
        updateSectionInFlashCardSetViewController()
        navigationController?.popViewController(animated: true)
                
    }
    private func updateSectionInFlashCardSetViewController(){
        whichControllerPushed == 0 ? flashCardSetViewControllerDelegate?.didAddFlashcardToSet() : flashCardListViewControllerDelegate?.didAddFlashcardToList()
    }
}
