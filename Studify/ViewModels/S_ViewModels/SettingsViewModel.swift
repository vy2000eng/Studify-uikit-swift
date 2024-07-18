//
//  SettingsViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation
import UIKit


class SettingsViewModel{
    var isIntermediaryThemeDark : Bool
    var currentTheme            : AppTheme
    var currentFontTheme        : themeFont
    let themeTitle              = ["SuperNova", "DarkPastel", "StormySea","CloudySunset"]
    let fontTitle               = ["Avenir","BaskerVille", "Georgia", "HelveticaNeue","Verdana", "GillSans","Optima","AmericanTypeWriter","AppleSDGothicNeo","Damascus"]
    let cellTitle               = ["Subject", "Topic", "Map", "Top Set", "Bottom Set", "Top List", "Bottom List"]
    //let selectedRow             = 0
  
      
    init() {
        currentFontTheme = FontManager.shared.currentThemeFont
        currentTheme = ColorManager.shared.currentTheme
        isIntermediaryThemeDark = currentTheme.colors.backGroundColor == .black ? true:false
    }
    
    func setTheme(theme: AppTheme){
        ColorManager.shared.setTheme(theme:theme)
        currentTheme = ColorManager.shared.currentTheme
        isIntermediaryThemeDark = currentTheme.colors.backGroundColor == .black ? true:false
    }
    
    func setFontTheme(themeFont: themeFont){
        FontManager.shared.setThemeFont(themeFont:  themeFont)
        currentFontTheme = FontManager.shared.currentThemeFont
    }
    
    var subjectColor: UIColor {
        return currentTheme.colors.subjectColor
    }
    
    var topicColor: UIColor {
        return currentTheme.colors.topicColor
    }
    
    var mapColor: UIColor {
        return currentTheme.colors.mapColor
    }
    
    var topColor: UIColor {
        return currentTheme.colors.topColor
    }
    
    var bottomColor: UIColor {
        return currentTheme.colors.bottomColor
    }
    
    var backgroundColor:UIColor{
        return currentTheme.colors.backGroundColor
    }
    
    var primaryFont:UIFont{
        return currentTheme.colors.primaryFont
    }
    
    var secondaryFont:UIFont{
        return currentTheme.colors.secondaryFont
    }
    
    var tertiaryFont:UIFont{
        return currentTheme.colors.tertiaryFont
    }
    
    var fontColor:UIColor{
        return currentTheme.colors.fontColor
    }
}

//    var currentTheme: AppTheme {
//         get { ColorManager.shared.currentTheme }
//        set { ColorManager.shared.setTheme(theme:newValue) }
//     }
