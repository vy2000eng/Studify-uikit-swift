//
//  ThemeDmContainerVM.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/4/24.
//

import Foundation

class ThemeDmContainerVM{
    var themeViewModel = [ThemeDmViewModel]()
    
    init(appThemeDmId:UUID){
        getAllThemeDMViewModel(appThemeId: appThemeDmId)
    }
    
    
    
    var themeVmCount:Int{
        themeViewModel.count
    }
    
    
    func getAllThemeDMViewModel(appThemeId:UUID){
        themeViewModel = CoreDataManager.shared.getAllThemeDMForAppThemeDm(appThemeDmId: appThemeId).map(ThemeDmViewModel.init)
        
    }
    
    func insertIntoAppThemeDM(theme:Theme, appThemeDMId:UUID){
        CoreDataManager.shared.insertThemeDMIntoAppThemeDM(theme: theme , appThemeDMId: appThemeDMId)
        
    }
    
}
