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
    //MARK: seeding data
    private func seedData(){

        let themeDMContainerViewModel = ThemeDmContainerVM()
        var themeTitle = ["SuperNova"]
        let t = Theme(
                     topicColor: .spaceCadet.withAlphaComponent(0.5),
                     topColor: .prussianBlue.withAlphaComponent(0.4),
                     bottomColor: .kobicha.withAlphaComponent(0.4),
                     fontColor: UIColor.white,
                     fontColorSecondary: .darkFontSecondary,
                     backGroundColor: .black,
                     primaryFont: FontManager.shared.primaryFont(style: .bold, size: 17),
                     secondaryFont: FontManager.shared.primaryFont(style: .semiBold, size: 14),
                     tertiaryFont: FontManager.shared.primaryFont(style: .italic, size: 14),
                     regularFont: FontManager.shared.primaryFont(style: .regular, size: 14)
       )
        themeDMContainerViewModel.insertIntoAppThemeDM(theme: t, themeTitle: "SuperNova")
    }

}
