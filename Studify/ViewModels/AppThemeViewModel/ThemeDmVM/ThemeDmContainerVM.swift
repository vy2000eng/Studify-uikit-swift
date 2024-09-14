//
//  ThemeDmContainerVM.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/4/24.
//

import Foundation

class ThemeDmContainerVM{
    var themeViewModel = [ThemeDmViewModel]()
    
    init(){
        getAllThemeDMViewModel()
    }
    
    
    
    var themeVmCount:Int{
        themeViewModel.count
    }
    
    
    func getAllThemeDMViewModel(){
        themeViewModel = CoreDataManager.shared.getAllThemeDM().map(ThemeDmViewModel.init)
        
    }
    
    func insertIntoAppThemeDM(theme:Theme,  themeTitle:String){
        CoreDataManager.shared.addNewThemeDM(theme: theme , title: themeTitle)
        
    }
    
}
