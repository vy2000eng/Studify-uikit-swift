//
//  AppThemeViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/4/24.
//

import Foundation

struct AppThemeDMViewModel{
    private var appThemeDm:AppThemeDM
    
    init(appThemeDm: AppThemeDM) {
        self.appThemeDm = appThemeDm
    }
    
    var id:UUID{
        appThemeDm.themeId
    }
    
    var title:String{
        appThemeDm.themeTitle
    }
    
    
    
}
