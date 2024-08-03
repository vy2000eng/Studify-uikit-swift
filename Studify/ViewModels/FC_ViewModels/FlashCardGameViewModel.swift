//
//  FlashCardGameViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/27/24.
//

import Foundation


class FlashCardGameViewModel{
    var topicID: UUID
    
    var currentIndex:Int
    
    
    
    init(topicID:UUID){
        self.topicID = topicID
        currentIndex = 0
      
        getAllFlashcardsForGame()
        
    }
    
    var gameFlashCards = [FlashcardViewModel]()

    
    var numberOfGameFlashCards:Int{
        gameFlashCards.count
    }
    
    func getAllFlashcardsForGame(){
        gameFlashCards = CoreDataManager.shared.getAllFlashCardsForTopic(topicID: topicID).map(FlashcardViewModel.init)
        
    }
    
    func flashcard(by index: Int) -> FlashcardViewModel{
        gameFlashCards[index]
    }

}
