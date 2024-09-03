//
//  TopicOptionsViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 8/24/24.
//

import Foundation
import UIKit

class TopicOptionsViewModel{
    
    
    
    var background:UIColor{
        ColorManager.shared.currentTheme.colors.backGroundColor
    }
    
    var fontColor:UIColor{
        ColorManager.shared.currentTheme.colors.fontColor
    }
    var titleFont:UIFont{
        ColorManager.shared.currentTheme.colors.primaryFont
    }
    var subtitleFont:UIFont{
        ColorManager.shared.currentTheme.colors.secondaryFont

        
    }
    
    
    
    
    
    
}
