//
//  FlashcardSetViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/9/24.
//

import Foundation

protocol didAddFlashCardToListViewControllerDelegate{
    func didAddFlashCardToListView()
}

protocol didAddFlashCardToSetViewControllerDelegate{
    func didAddFlashCardToSetView()
}

class SmallSetSection{
    let data:[FlashcardViewModel]
    var isOpened:Bool = true
    init(data: [FlashcardViewModel], isOpened: Bool = true) {
        self.data = data
        self.isOpened = isOpened
    }
}



class FlashcardSetViewModel{
    
    var topicID: UUID

    
    var flashcards = [FlashcardViewModel]()
    
    var currentIndex:Int
    
    var smallSetSection: SmallSetSection
    


    
    
    var numberOfFlashCards:Int{
        flashcards.count
    }
    
    init(topicID: UUID) {
        self.topicID = topicID
        self.currentIndex = 0
        self.smallSetSection = SmallSetSection(data: flashcards)

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
    
    func flashcardDisplayMode(by index: Int){
        let fc = flashcard(by: index)
        fc.isShowingFront = !fc.isShowingFront
        
        
        
    }
    
    func initSmallSetSection(){
        getAllFlashcards()
        smallSetSection = SmallSetSection(data: flashcards)
        
    }
    
    func toggleSection(){
        smallSetSection.isOpened = !smallSetSection.isOpened
    }
    
    func isSectionCollapsed() -> Bool{
        return smallSetSection.isOpened
    }
    
}
