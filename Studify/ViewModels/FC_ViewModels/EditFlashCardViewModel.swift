//
//  EditFlashCardViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/27/24.
//

import Foundation
class EditFlashCardViewModel{
    let flashcardId: UUID
    
    init(flashcardId: UUID) {
        self.flashcardId = flashcardId
    }
    
    func editFlashCard(front: String, back:String){
        CoreDataManager.shared.updateFlashcard(flashcardID: flashcardId, front: front, back: back)
        
    } 
    
    func deleteFlashCard(){
        CoreDataManager.shared.deleteFlashCard(flashCardID: flashcardId)
        
    }
}
