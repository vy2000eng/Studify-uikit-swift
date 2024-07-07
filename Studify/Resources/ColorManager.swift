//
//  ColorsManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation


class ColorManager{
    static let shared = ColorManager()
    
    private(set) var currentTheme: AppTheme {
        didSet {
            saveTheme()
        }
    }
    
    // private(set) var currentTheme: AppTheme
    
    private init() {
        self.currentTheme = .themeOne
        
        // Then load the saved theme, if any
        if let loadedTheme = loadTheme() {
            self.currentTheme = loadedTheme
        }
        //self.currentTheme = loadTheme()
    }
    
    func setTheme( theme: AppTheme) {
        self.currentTheme = theme
    }
    
    private func saveTheme() {
        UserDefaults.standard.set(currentTheme.rawValue, forKey: "AppTheme")
    }
    
    private func loadTheme() -> AppTheme? {
        if let savedThemeRawValue = UserDefaults.standard.object(forKey: "AppTheme") as? Int,
           let savedTheme = AppTheme(rawValue: savedThemeRawValue) {
            return savedTheme
        }
        return .themeOne // Default theme
    }
    
    
    
}
