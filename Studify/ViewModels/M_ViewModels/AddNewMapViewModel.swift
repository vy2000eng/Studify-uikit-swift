//
//  AddNewMapViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/7/24.
//

import Foundation
import UIKit


class AddNewMapViewModel{
    let subjectID: UUID
    init(subjectID: UUID) {
        self.subjectID = subjectID
    }
    
    func addMap(title:String){
        CoreDataManager.shared.addMapToSubject(title: title, subjectID: subjectID)
    }
    
    var currentTheme:Theme{
        ColorManager.shared.currentTheme.colors
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
