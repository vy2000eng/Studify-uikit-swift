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
    
    var background:UIColor{
        ColorManager.shared.currentTheme.colors.backGroundColor
    }
    
    var id: UUID{
        flashcard.id
    }

    var front:String{
        flashcard.front
    }
    
    var back:String{
        flashcard.back
    }

    var topBackgroundColor:UIColor{
        return ColorManager.shared.currentTheme.colors.topColor
    }
    
    var bottomBackgroundColor:UIColor{
        return ColorManager.shared.currentTheme.colors.bottomColor
        
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
    var regularFont:UIFont{
        ColorManager.shared.currentTheme.colors.regularFont
    }
    
    func setFrontString(front: String){
        flashcard.front = front
    }
    
    func setBackString(back: String){
        flashcard.back = back
    }
    
}
