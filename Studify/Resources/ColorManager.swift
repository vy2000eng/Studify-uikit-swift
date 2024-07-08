//
//  ColorsManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation

extension Notification.Name {
    static let themeDidChange = Notification.Name("themeDidChange")
    
   
}

class ColorManager{
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    static let shared = ColorManager()
    
    private(set) var currentTheme: AppTheme {
        didSet {
            saveTheme()
        }
    }
    
    // private(set) var currentTheme: AppTheme
    
    private init() {
        self.currentTheme = .themeOne
        
        if let loadedTheme = loadTheme() {
            self.currentTheme = loadedTheme
        }
    }
    
    func setTheme( theme: AppTheme) {
        self.currentTheme = theme
        NotificationCenter.default.post(name: .themeDidChange, object: nil)

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
