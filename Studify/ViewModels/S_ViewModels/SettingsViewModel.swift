//
//  SettingsViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation
import UIKit


class SettingsViewModel{
   // let currentTheme = ColorManager.shared.currentTheme
   // let setting  = Setting()
    let title = ["SuperNova", "ThunderStorm", "StormySea"]
    
    let selectedRow = 0
    
    var currentTheme: AppTheme {
         get { ColorManager.shared.currentTheme }
        set { ColorManager.shared.setTheme(theme:newValue) }
     }
    
    
    func setTheme(theme: AppTheme){
        ColorManager.shared.setTheme(theme:theme)

    }
    
 
    
    var subjectColor: UIColor {
        return ColorManager.shared.currentTheme.colors.subjectColor
    }
    
    var topicColor: UIColor {
        return ColorManager.shared.currentTheme.colors.topicColor
    }
    
    var mapColor: UIColor {
        return ColorManager.shared.currentTheme.colors.mapColor
    }
    
    var setTopColor: UIColor {
        return ColorManager.shared.currentTheme.colors.topColor
    }
    
    var setBottomColor: UIColor {
        return ColorManager.shared.currentTheme.colors.bottomColor
    }
    
    
    var listTopColor: UIColor {
        return ColorManager.shared.currentTheme.colors.topColor
    }
    
    var listBottomColor: UIColor {
        return ColorManager.shared.currentTheme.colors.bottomColor
    }
    
    var fontColor:UIColor{
        return ColorManager.shared.currentTheme.colors.fontColor
    }
    var backgroundColor:UIColor{
        return ColorManager.shared.currentTheme.colors.backGroundColor
    }
    
    
}
//struct Setting{
//    
//    
//   
//    
//    
//    var subjectColor: UIColor {
//        return ColorManager.shared.currentTheme.colors.subjectColor
//    }
//    
//    var topicColor: UIColor {
//        return ColorManager.shared.currentTheme.colors.topicColor
//    }
//    
//    var mapColor: UIColor {
//        return ColorManager.shared.currentTheme.colors.mapColor
//    }
//    
//    var setColor: UIColor {
//        return ColorManager.shared.currentTheme.colors.setColor
//    }
//    
//    var listColor: UIColor {
//        return ColorManager.shared.currentTheme.colors.listColor
//    }
//    
//}

//
//struct Setting{
//    let appTheme:AppTheme
//    init(appTheme: AppTheme) {
//        self.appTheme = appTheme
//    }
////    let subjectColor:UIColor
////    let listColor:UIColor
////    let topicColor:UIColor
////    let mapColor:UIColor
////    let setColor: UIColor
////    
////    init(theme: Theme) {
////        self.subjectColor = theme.subjectColor
////        self.listColor = theme.listColor
////        self.topicColor = theme.topicColor
////        self.mapColor = theme.mapColor
////        self.setColor = theme.setColor
////    }
//    
//    
//}
