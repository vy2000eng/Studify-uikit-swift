//
//  AppThemeViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/4/24.
//

import Foundation
import UIKit

struct AppThemeDMViewModel{
    private var appThemeDm:AppThemeDM
    
    init(appThemeDm: AppThemeDM) {
        self.appThemeDm = appThemeDm
        printbackGroundColor()
    }
    
    var id:UUID{
        appThemeDm.themeId
    }
    
    var title:String{
        appThemeDm.themeTitle
    }
    
    func printbackGroundColor(){
        let color:UIColor =  ColorManager.shared.currentTheme.colors.bottomColor
        print(color.description)
        
    }
    
    
    
}
