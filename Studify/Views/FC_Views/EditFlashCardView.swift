//
//  EditFlashCardView.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/27/24.
//

import Foundation

class EditFlashCardView: AddNewFlashCardView{
    var flashCardViewModel: FlashcardViewModel
    
    init(frame: CGRect, flashcardViewModel: FlashcardViewModel) {
        self.flashCardViewModel = flashcardViewModel
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditFlashCardView{
    private func setup(){
        frontStringTextField.text = flashCardViewModel.front
        backStringTextField.text = flashCardViewModel.back
        
    }
}
