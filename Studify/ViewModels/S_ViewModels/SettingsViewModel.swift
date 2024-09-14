//
//  SettingsViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation
import UIKit


class SettingsViewModel{
   // var appThemeContainerViewModel :AppThemeDMContainerViewModel
    var themeDMContainerViewModel: ThemeDmContainerVM
    var isIntermediaryThemeDark : Bool
    var currentTheme            : AppTheme
    var currentFontTheme        : themeFont
   // var themeTitle              = ["SuperNova", "DarkPastel", "StormySea","CloudySunset"]
    let fontTitle               = ["Avenir","BaskerVille", "Georgia", "HelveticaNeue","Verdana", "GillSans","Optima","AmericanTypeWriter","AppleSDGothicNeo","Damascus"]
    let cellTitle               = [ "Topic",  "Top Set", "Bottom Set", "Top List", "Bottom List"]
    //let selectedRow             = 0
  
      
    init() {
       // appThemeContainerViewModel = AppThemeDMContainerViewModel()
        
        //MARK: part of test code
        themeDMContainerViewModel = ThemeDmContainerVM()
        //MARK: part of test code

        currentFontTheme = FontManager.shared.currentThemeFont
        currentTheme = ColorManager.shared.currentTheme
        isIntermediaryThemeDark = currentTheme.colors.backGroundColor == .black ? true:false
        //testInsertingthemeTitle()
       // testAddThemeToAppTheme()
    }
    
    var themeCount:Int{
        //appThemeContainerViewModel.themecount
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
    
    func addNewAppThemeDM(title:String){
        //appThemeContainerViewModel.insertTheme(title: title)
        
    }
    
    
    
    
//    var subjectColor: UIColor {
//        return currentTheme.colors.subjectColor
//    }
    
    var topicColor: UIColor {
        return currentTheme.colors.topicColor
    }
    
    
//    var mapColor: UIColor {
//        return currentTheme.colors.mapColor
//    }
    
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
        //return appThemeContainerViewModel.appThemeViewModel[row].title
        
    }
}

//    var currentTheme: AppTheme {
//         get { ColorManager.shared.currentTheme }
//        set { ColorManager.shared.setTheme(theme:newValue) }
//     }
extension SettingsViewModel{
    //MARK: seeing if this will work
    
//    func testInsertingthemeTitle(){
//        var themeTitle              = ["SuperNova", "DarkPastel", "StormySea","CloudySunset"]
//
//        for title in themeTitle {
//            appThemeContainerViewModel.insertTheme(title:title)
//        }
//        
//        
//    }
    
    
    
    func testAddThemeToAppTheme(){
        
        
        
        
//        var t = Theme(
//           //subjectColor: .russianViolet.withAlphaComponent(0.5),
//                     topicColor: .spaceCadet.withAlphaComponent(0.5),
//                     //mapColor: .tyrianPurple.withAlphaComponent(0.3),
//                     topColor: .prussianBlue.withAlphaComponent(0.4),
//                     bottomColor: .kobicha.withAlphaComponent(0.4),
//                     fontColor: UIColor.white,
//                     fontColorSecondary: .darkFontSecondary,
//                     backGroundColor: .black,
//                     primaryFont: FontManager.shared.primaryFont(style: .bold, size: 17),
//                     secondaryFont: FontManager.shared.primaryFont(style: .semiBold, size: 14),
//                     tertiaryFont: FontManager.shared.primaryFont(style: .italic, size: 14),
//                     regularFont: FontManager.shared.primaryFont(style: .regular, size: 14)
//       )
        var t = Theme(
           //subjectColor: .russianViolet.withAlphaComponent(0.5),
                     topicColor: .blue,
                     //mapColor: .tyrianPurple.withAlphaComponent(0.3),
                     topColor: .red,
                     bottomColor: .green,
                     fontColor: UIColor.white,
                     fontColorSecondary: .gray,
                     backGroundColor: .black,
                     primaryFont: FontManager.shared.primaryFont(style: .bold, size: 17),
                     secondaryFont: FontManager.shared.primaryFont(style: .semiBold, size: 14),
                     tertiaryFont: FontManager.shared.primaryFont(style: .italic, size: 14),
                     regularFont: FontManager.shared.primaryFont(style: .regular, size: 14)
       )
        
        
//
     ///   themeDMContainerViewModel.insertIntoAppThemeDM(theme: t, appThemeDMId: appThemeContainerViewModel.appThemeViewModel[10].id)
    }
    
    
    
    
    
    
    
}
