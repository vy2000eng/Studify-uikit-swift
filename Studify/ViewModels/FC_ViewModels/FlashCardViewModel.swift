//
//  FlashCardViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/9/24.
//

import Foundation
import UIKit

//TODO: realzied we are us
class FlashcardViewModel{
    
    private var flashcard : FlashCard
    
    var isShowingFront = true
    
    init(flashcard: FlashCard) {
        self.flashcard = flashcard
    }
    
    var id: UUID{
        flashcard.id
    }
    
    var setBackgroundColor:UIColor{
        return ColorManager.shared.currentTheme.colors.setColor
        
    }
    
    var listBackgroundColor:UIColor{
        return ColorManager.shared.currentTheme.colors.listColor

        
    }
    
    var front:String{
        flashcard.front
    }
    
    var back:String{
        flashcard.back
    }
    
    func setFrontString(front: String){
        flashcard.front = front
    }
    
    func setBackString(back: String){
        flashcard.back = back
    }
    
    
    
    
}
