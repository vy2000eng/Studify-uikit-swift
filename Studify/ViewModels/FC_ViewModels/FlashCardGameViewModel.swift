//
//  FlashCardGameViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/27/24.
//

import Foundation
import UIKit


class FlashCardGameViewModel{
    var topicID: UUID
    
    var currentIndex:Int
    
    var backGroundColor:UIColor{
        return ColorManager.shared.currentTheme.colors.mapColor
        
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
