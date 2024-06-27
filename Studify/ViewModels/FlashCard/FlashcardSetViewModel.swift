//
//  FlashcardSetViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/9/24.
//

import Foundation
//protocol AddNewFlashCardToSetViewControllerDelegate: AnyObject{
//    func didAddFlashcardToSet()
//}
//
//protocol AddNewFlashCardToListViewControllerDelegate: AnyObject{
//    func didAddFlashcardToList()
//}

protocol didAddFlashCardToListViewControllerDelegate{
    func didAddFlashCardToListView()
}

protocol didAddFlashCardToSetViewControllerDelegate{
    func didAddFlashCardToSetView()
}

class FlashcardSetViewModel{
    
    var topicID: UUID
    
    var flashcards = [FlashcardViewModel]()
    
   // weak var flashCardSetViewControllerDelegate: AddNewFlashCardToSetViewControllerDelegate?
   // weak var flashCardListViewControllerDelegate: AddNewFlashCardToListViewControllerDelegate?
    
    var numberOfFlashCards:Int{
        flashcards.count
    }
    
    init(topicID: UUID) {
        self.topicID = topicID
        getAllFlashcards()
    }
    
    
    func numberOfRowsForflashCards() -> Int{
        return numberOfFlashCards
    }
    
    func flashcard(by index: Int) -> FlashcardViewModel{
        flashcards[index]
    }
    
    func getAllFlashcards(){
        flashcards = CoreDataManager.shared.getAllFlashCardsForTopic(topicID: topicID).map(FlashcardViewModel.init)
        
    }
    
    func deleteFlashcard(flashcard:FlashcardViewModel){
        CoreDataManager.shared.deleteFlashCard(flashCardID: flashcard.id)
        getAllFlashcards()
        
    }
    
}
