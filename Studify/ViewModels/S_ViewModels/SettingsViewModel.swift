//
//  SettingsViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation
import UIKit


class SettingsViewModel{
    var themeDMContainerViewModel: ThemeDmContainerVM
    var isIntermediaryThemeDark : Bool
    var currentTheme            : AppTheme
    var currentFontTheme        : themeFont
    let fontTitle               = ["Avenir","BaskerVille", "Georgia", "HelveticaNeue","Verdana", "GillSans","Optima","AmericanTypeWriter","AppleSDGothicNeo","Damascus"]
    let cellTitle               = [ "Topic",  "Top Set", "Bottom Set", "Top List", "Bottom List"]
    
    
    init() {
        themeDMContainerViewModel = ThemeDmContainerVM()
        currentFontTheme = FontManager.shared.currentThemeFont
        currentTheme = ColorManager.shared.currentTheme
        isIntermediaryThemeDark = currentTheme.colors.backGroundColor == .black ? true:false
    }
    
    var themeCount:Int{
        themeDMContainerViewModel.themeVmCount
        
    }
    var fontCount:Int{
        fontTitle.count
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
    
    
    var topicColor: UIColor {
        return currentTheme.colors.topicColor
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
    
    func appDmTheme(by row: Int) ->String{
        return themeDMContainerViewModel.themeViewModel[row].themeTitle
        
    }
}


