//
//  AddNewFlashCardViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import Foundation
import UIKit

class AddNewFlashCardViewModel{
    let topicID: UUID
    
    init(topicID: UUID) {
        self.topicID = topicID
    }
    
    func addFlashcard(front:String, back:String){
        CoreDataManager.shared.addflashCardToTopic(front: front, back: back, topicID: topicID)
    }
    
    
    
    var backGroundColor:UIColor{
        return ColorManager.shared.currentTheme.colors.backGroundColor
        
    }
    var regularFont:UIFont{
        ColorManager.shared.currentTheme.colors.regularFont

        
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

    
    
}
