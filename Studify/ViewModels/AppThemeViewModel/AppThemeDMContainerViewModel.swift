//
//  AppThemeContainerViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/4/24.
//

import Foundation
class AppThemeDMContainerViewModel{
    var appThemeViewModel = [AppThemeDMViewModel]()
  

    init() {
        getAllThemes()

    }
    var themecount:Int{
        appThemeViewModel.count
    }

    
    private func getAllThemes() {
        appThemeViewModel = CoreDataManager.shared.getAllAppThemes().map(AppThemeDMViewModel.init)
    }
    
    func insertTheme(title:String){
        CoreDataManager.shared.addNewTheme(title: title)
        getAllThemes()
    }
    
}
