//
//  DataManager.swift
//  Studify
//
//  Created by Vladyslav Yatsuta on 9/13/24.
//

import Foundation
import UIKit
class DataManager{
    static let shared = DataManager()
    private let defaults = UserDefaults.standard
    private let hasSeededData = "hasSeededData"
    
    func seedDataIfNeeded(){
        if !defaults.bool(forKey: hasSeededData){
            seedData()
            defaults.setValue(true, forKey: hasSeededData)
        }
        
    }
    
    private func seedData(){
        let appThemeContainerViewModel = AppThemeDMContainerViewModel()

        var themeTitle = ["SuperNova", "DarkPastel", "StormySea","CloudySunset"]
        
        
        for title in themeTitle {
            appThemeContainerViewModel.insertTheme(title:title)
        }
        

        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
