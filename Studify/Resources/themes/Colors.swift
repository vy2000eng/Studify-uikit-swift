//
//  Colors.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/7/24.
//

import Foundation
import UIKit

struct OceanSandTheme{
    static let darkPrimary = UIColor(named:"darkblue")
    static let darkSecondary = UIColor(named:"oceanblue")
    static let lightPrimary = UIColor(named: "lightpeach")
    static let lightSecondary = UIColor(named: "tan")
    static let lightTertiary = UIColor(named: "pastelyellow")
    static let georgiaFont15 = UIFont(name: "Georgia", size: 15)
    static let georgiaFont12 = UIFont(name: "Georgia", size: 12)
}

struct warmClouds{
    static let darkPrimary = UIColor(named: "Cyclamen")
    static let darkSecondary = UIColor(named: "Amaranth Pink")
    static let lightPrimary = UIColor(named: "Pink Lace")
    static let lightSecondary = UIColor(named: "Beige")
    static let lightTertiary = UIColor(named: "Powder Blue")
}

struct warmTreeTones{
    static let darkPrimary = UIColor(named: "Apricot")
    static let darkSecondary = UIColor(named: "Melon")
    static let lightPrimary = UIColor(named: "Pastel Pink")
    static let lightSecondary = UIColor(named: "English Lavender")
    static let lightTertiary = UIColor(named: "Old Lavender")
    
    
    
}

struct Theme{
    
    let subjectColor: UIColor
    let topicColor: UIColor
    let mapColor: UIColor
    let setColor: UIColor
    let listColor: UIColor
}
    
    
enum AppTheme: Int, CaseIterable{
    case themeOne = 0
      case oceanSand = 1
      case warmClouds = 2
      case warmTreeTones = 3
    case mildWinter = 4
    case royalty = 5
    
    var colors:Theme {
        switch self {
        case .themeOne:
            return Theme(subjectColor: .charcoal,
                         topicColor: .persianGreen,
                         mapColor: .saffron,
                         setColor: .sandyBrown,
                         listColor: .burntSienna)
        case .oceanSand:
            return Theme(subjectColor:.darkblue,
                         topicColor: .oceanblue,
                         mapColor: .lightpeach,
                         setColor: .tan,
                         listColor: .pastelyellow)
        case .warmClouds:
            return Theme(subjectColor: .cyclamen,
                         topicColor: .amaranthPink,
                         mapColor: .pinkLace,
                         setColor: .powderBlue,
                         listColor: .beige)
            
        case .warmTreeTones:
            return Theme(subjectColor: .oldLavender,
                         topicColor: .englishLavender,
                         mapColor: .pastelPink,
                         setColor: .melon,
                         listColor: .apricot)
            
        case .mildWinter:
            return Theme(subjectColor: .pantone,
                         topicColor: .honeyDew,
                         mapColor: .nonPhotoBlue,
                         setColor: .cerulean,
                         listColor: .berkeleyBlue)
        case .royalty:
            return Theme(subjectColor: .tyrianPurple,
                         topicColor: .carmine,
                         mapColor: .utOrange,
                         setColor: .spanishOrange,
                         listColor: .midnightGreen)
        }
        
    }
}
    
    
    //
    //class AppColors{
    //
    //    var currentTheme: AppTheme
    //
    //    init() {
    //        self.currentTheme = AppTheme.themeOne
    //    }
    //}
    
    
    //    struct ThemeOne {
    //        init() {
    //            sself.subjectColor = .charcoal
    //            self.topicColor = .persianGreen
    //            self.mapColor = .saffron
    //            self.setColor = .sandyBrown
    //            self.listColor = .burntSienna
    //        }
    //    }
    //    struct OceanSandTheme{
    //        static let subjectColor = UIColor(named:"darkblue")
    //        static let topicColor = UIColor(named:"oceanblue")
    //        static let mapColor = UIColor(named: "lightpeach")
    //        static let setColor = UIColor(named: "tan")
    //        static let listColor = UIColor(named: "pastelyellow")
    //        static let georgiaFont15 = UIFont(name: "Georgia", size: 15)
    //        static let georgiaFont12 = UIFont(name: "Georgia", size: 12)
    //    }
    //
    //    struct warmClouds{
    //        static let subjectColor = UIColor(named: "Cyclamen")
    //        static let topicColor = UIColor(named:"Amaranth Pink")
    //        static let mapColor = UIColor(named: "Pink Lace")
    //        static let setColor = UIColor(named: "Beige")
    //        static let listColor = UIColor(named: "Powder Blue")
    //    }
    //
    //    struct warmTreeTones{
    //        static let subjectColor = UIColor(named: "Apricot")
    //        static let topicColor = UIColor(named: "Melon")
    //        static let mapColor = UIColor(named: "Pastel Pink")
    //        static let setColor = UIColor(named: "English Lavender")
    //        static let listColor = UIColor(named: "Old Lavender")
    //
    //
    //
    //    }
    

