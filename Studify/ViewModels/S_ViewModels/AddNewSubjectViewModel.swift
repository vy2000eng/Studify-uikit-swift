//
//  AddNewSubjectViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/3/24.
//

import Foundation
import UIKit

class AddNewSubjectViewModel{
    func addSubject(title:String, createdOn: Date){
        CoreDataManager.shared.addNewSubject(title: title, createdOn:createdOn)
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
