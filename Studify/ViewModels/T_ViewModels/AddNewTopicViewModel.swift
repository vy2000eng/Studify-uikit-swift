//
//  AddNewTopicViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/7/24.
//

import Foundation
import UIKit

class AddNewTopicViewModel{
    let subjectId: UUID
    
    init(subjectId: UUID) {
        self.subjectId = subjectId
    }
    
    var currentTheme:Theme{
        ColorManager.shared.currentTheme.colors
    }
    
    
    func addTopic(title: String ){
        CoreDataManager.shared.addTopicToSubject(title: title, subjectID: subjectId)
    }
    
    var fontColor:UIColor{
        ColorManager.shared.currentTheme.colors.fontColor

        
    }
    var font:UIFont{
        ColorManager.shared.currentTheme.colors.regularFont
    }
    
    var titleFont:UIFont{
        ColorManager.shared.currentTheme.colors.primaryFont
        
    }
}
