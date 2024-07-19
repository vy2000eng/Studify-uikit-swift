//
//  EditFlashCardView.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/27/24.
//

import Foundation

class EditFlashCardView: AddNewFlashCardView{
    var flashCardViewModel: FlashcardViewModel
    var addNewFlashCardViewModel:AddNewFlashCardViewModel
    

    
    init(frame: CGRect, flashcardViewModel: FlashcardViewModel) {
        self.flashCardViewModel = flashcardViewModel
        self.addNewFlashCardViewModel = AddNewFlashCardViewModel(topicID: UUID())
        super.init(addFlashCardViewmodel: addNewFlashCardViewModel, frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditFlashCardView{
    private func setup(){
        backgroundColor = .clear

        let attrTextFront = NSAttributedString(string: flashCardViewModel.front  ,
                                          attributes: [.foregroundColor: addNewFlashCardViewModel.fontColor,
                                                       .font: addNewFlashCardViewModel.regularFont])
        
        let attrTextBack = NSAttributedString(string: flashCardViewModel.back  ,
                                          attributes: [.foregroundColor: addNewFlashCardViewModel.fontColor,
                                                       .font: addNewFlashCardViewModel.regularFont])
        
        
        frontStringTextField.attributedText = attrTextFront
        backStringTextField.attributedText = attrTextBack
        
//        frontStringTextField.text = flashCardViewModel.front
//        backStringTextField.text = flashCardViewModel.back
//        
    }
}
