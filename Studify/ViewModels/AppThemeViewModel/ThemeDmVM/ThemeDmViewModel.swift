//
//  ThemeDmViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/4/24.
//

import Foundation
import UIKit


class ThemeDmViewModel{
    private var themeDM:ThemeDM
    
    init(themeDM: ThemeDM) {
        self.themeDM = themeDM
        printbackGroundColor()
    }
    
    func printbackGroundColor(){
        let color:UIColor =  ColorManager.shared.currentTheme.colors.topColor
        print(color.description)
        
    }
    
}
