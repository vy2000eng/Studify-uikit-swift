//
//  FlashcardSetViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/9/24.
//

import Foundation
import UIKit

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
    
    var viewControllerCurrentlyAppearing:Int
    
    var numberOfFlashCards:Int{
        flashcards.count
    }
    
    var background:UIColor{
        ColorManager.shared.currentTheme.colors.backGroundColor
    }
    var fontColor:UIColor{
        return ColorManager.shared.currentTheme.colors.fontColor
    }
    var fontColorSecondary:UIColor{
        return ColorManager.shared.currentTheme.colors.fontColorSecondary
    }
    
    var titleFont:UIFont{
        ColorManager.shared.currentTheme.colors.primaryFont
    }
    var subtitleFont:UIFont{
        ColorManager.shared.currentTheme.colors.secondaryFont
    }
    

    
    init(topicID: UUID) {
        print("init")
        self.topicID = topicID
        self.currentIndex = 0
        self.smallSetSection = SmallSetSection(data: flashcards)
        self.viewControllerCurrentlyAppearing = 0
        
        getAllFlashcards()
    }
    
    var sectionsCount:Int{
        return numberOfFlashCards > 0 ? 2 : 0
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
    
    func getLearnedFlashcards(){
        flashcards = flashcards.lazy.filter({$0.learned})
    }
    
    func getStillLearningFlashcards(){
        flashcards = flashcards.lazy.filter({$0.stillLearning})

        
    }
    
    func toggleLearnedFlashcard(flashcardID:UUID){
        CoreDataManager.shared.toggleLearned(flashcardID: flashcardID)
    }
    
    func toggleStillLearninigFlashcard(flashcardID:UUID){
        CoreDataManager.shared.toggleStillLearning(flashcardID: flashcardID)
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
