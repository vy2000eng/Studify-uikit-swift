//
//  ColorsManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation
import UIKit

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
        self.currentTheme = .superNova
        
        if let loadedTheme = loadTheme() {
            self.currentTheme = loadedTheme
            //self.currentTheme.colors.themeFont =
            //self.currentTheme.colors.primaryFont = themeFont(rawValue: 0)
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
        return .superNova// Default theme
    }
    var themeFont:Font{
        FontManager.shared.currentThemeFont.font
    }
    
    
    
}


class FontManager{
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    static let shared = FontManager()
    
    private(set) var currentThemeFont: themeFont {
        didSet {
            saveThemeFont()
        }
    }
    
    
    private init() {
        self.currentThemeFont = .Avenir
        
        if let loadedFont = loadFont() {
            self.currentThemeFont = loadedFont
            //self.currentTheme.colors.primaryFont = themeFont(rawValue: 0)
        }
    }
    
    func setThemeFont( themeFont: themeFont) {
        self.currentThemeFont = themeFont
        NotificationCenter.default.post(name: .themeDidChange, object: nil)

    }
    
    func primaryFont(style: FontStyle, size: CGFloat) -> UIFont {
        return currentThemeFont.font.font(style: style, size: size)
    }
    
    private func saveThemeFont() {
        UserDefaults.standard.set(currentThemeFont.rawValue, forKey: "themeFont")
    }
    
    private func loadFont() -> themeFont? {
        if let savedThemeFontRawValue = UserDefaults.standard.object(forKey: "themeFont") as? Int,
           let savedThemeFont = themeFont(rawValue: savedThemeFontRawValue) {
            return savedThemeFont
        }
        return .Avenir// Default theme
    }
    
    
    
}
