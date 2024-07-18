//
//  Colors.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/7/24.
//

import Foundation
import UIKit

//struct OceanSandTheme{
//    static let darkPrimary = UIColor(named:"darkblue")
//    static let darkSecondary = UIColor(named:"oceanblue")
//    static let lightPrimary = UIColor(named: "lightpeach")
//    static let lightSecondary = UIColor(named: "tan")
//    static let lightTertiary = UIColor(named: "pastelyellow")
//    static let georgiaFont15 = UIFont(name: "Georgia", size: 15)
//    static let georgiaFont12 = UIFont(name: "Georgia", size: 12)
//}
//
//struct warmClouds{
//    static let darkPrimary = UIColor(named: "Cyclamen")
//    static let darkSecondary = UIColor(named: "Amaranth Pink")
//    static let lightPrimary = UIColor(named: "Pink Lace")
//    static let lightSecondary = UIColor(named: "Beige")
//    static let lightTertiary = UIColor(named: "Powder Blue")
//}
//
//struct warmTreeTones{
//    static let darkPrimary = UIColor(named: "Apricot")
//    static let darkSecondary = UIColor(named: "Melon")
//    static let lightPrimary = UIColor(named: "Pastel Pink")
//    static let lightSecondary = UIColor(named: "English Lavender")
//    static let lightTertiary = UIColor(named: "Old Lavender")
//    
//    
//    
//}

struct Theme{
    
    let subjectColor: UIColor
    let topicColor: UIColor
    let mapColor: UIColor
    let topColor: UIColor
    let bottomColor: UIColor

    let fontColor: UIColor
    let fontColorSecondary:UIColor
    let backGroundColor: UIColor
    //var themeFont:Font
    let primaryFont:UIFont
    let secondaryFont:UIFont
    let tertiaryFont: UIFont
    let regularFont:UIFont
}

/**
 
 
 let regular = UIFont(name: "Georgia", size: 17)
 let bold = UIFont(name: "Georgia-Bold", size: 17)
 let italic = UIFont(name: "Georgia-Italic", size: 17)
 
 let regular = UIFont(name: "Verdana", size: 17)
 let bold = UIFont(name: "Verdana-Bold", size: 17)
 let italic = UIFont(name: "Verdana-Italic", size: 17)
 
 let regular = UIFont(name: "HelveticaNeue", size: 17)
 let bold = UIFont(name: "HelveticaNeue-Bold", size: 17)
 let italic = UIFont(name: "HelveticaNeue-Italic", size: 17)
 
 let regular = UIFont(name: "TimesNewRomanPSMT", size: 17)
 let bold = UIFont(name: "TimesNewRomanPS-BoldMT", size: 17)
 let italic = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 17)
 
 */
    
//struct Font{
//    let primaryFont:UIFont
//    let secondaryFont:UIFont
//    let tertiaryFont: UIFont
//    
//}

enum FontStyle {
    case regular
    case semiBold
    case bold
    case italic
}
struct Font {
    let primaryFont: String
    
    
    func font(style: FontStyle, size: CGFloat) -> UIFont {
        switch style {
        case .regular:
            //baskerville is fine
            if primaryFont == "Avenir"{return UIFont(name: "Avenir-Book" , size: size) ?? UIFont.systemFont(ofSize: size)}
            if primaryFont == "Optima"{return UIFont(name: "Optima-Regular" , size: size) ?? UIFont.systemFont(ofSize: size)}
            if primaryFont == "AppleSDGothicNeo"{return UIFont(name: "AppleSDGothicNeo-Regular" , size: size) ?? UIFont.systemFont(ofSize: size)}

            return UIFont(name: primaryFont, size: size) ?? UIFont.systemFont(ofSize: size)
        case .semiBold:
            if primaryFont == "Avenir"{return UIFont(name: "Avenir-Medium" , size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)}
            if primaryFont == "Georgia"{return UIFont(name: "Georgia-Bold" , size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)}
            if primaryFont == "HelveticaNeue"{return UIFont(name: "HelveticaNeue-Medium" , size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)}
            if primaryFont == "Verdana"{return UIFont(name: "Verdana-Bold" , size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)}
            if primaryFont == "Optima"{return UIFont(name: "Optima-Bold" , size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)}

            return UIFont(name: "\(primaryFont)-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
            
        case .bold:
            
            if primaryFont == "Avenir"{return UIFont(name: "Avenir-Black" , size: size) ?? UIFont.boldSystemFont(ofSize: size) }
            if primaryFont == "Optima"{return UIFont(name: "Optima-ExtraBlack" , size: size) ?? UIFont.boldSystemFont(ofSize: size) }

            return UIFont(name: "\(primaryFont)-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
            
        case .italic:
            if primaryFont == "Avenir"{return UIFont(name: "Avenir-Oblique" , size: size) ?? UIFont.italicSystemFont(ofSize: size) }
            return UIFont(name: "\(primaryFont)-Italic", size: size) ?? UIFont.italicSystemFont(ofSize: size)
            
        }
    }
}
    
    enum themeFont: Int, CaseIterable{
        case Avenir = 0
        case BaskerVille = 1
        case Georgia = 2
        case Helvetica = 3
        case Verdana = 4
        case GillSans = 5
        case Optima = 6
        case AmericanTypeWriter = 7
        case AppleSdGothicNeo = 8
        case Damascus = 9
        
        var font:Font{
            switch self{
            case .Avenir:
                return Font(primaryFont: "Avenir")
                //Avenir-Book
                //Avenir-Medium
                //Avenir-Black
                
                
            case .BaskerVille:
                return Font(primaryFont: "Baskerville")
                //Baskerville
                //Baskerville-SemiBold
                //Baskerville-Bold
                //Baskerviller-Italic
                
            case .Georgia:
                return Font(primaryFont: "Georgia")
                //Georgia
                //Georgia-Bold
               // Georgia-Italic
                
            case .Helvetica:
                return Font(primaryFont: "HelveticaNeue")
                //HelveticaNeue
                //HelveticaNeue-Medium
                //HelveticaNeue-Bold
                //HelveticaNeue-Italic
                
            case .Verdana:
                return Font(primaryFont: "Verdana")
                //Verdana
                //Verdana-Bold
                //Verdana-Italic
                
            case .GillSans:
                return Font(primaryFont: "GillSans")
                //GillSans
                //GillSans-SemiBold
                //GillSans-Bold
                
            case .Optima:
                return Font(primaryFont: "Optima")
                //Optima-Regular
                //Optima-Bold
                //Optima-ExtraBlack
            case .AmericanTypeWriter:
                return Font(primaryFont: "AmericanTypewriter")
                //American Typewriter
                // American Typewriter Semibold
                //American Typewriter Bold
            case .AppleSdGothicNeo:
                return Font(primaryFont: "AppleSDGothicNeo")
                //Apple SD GothicNeo-Regular
                //Apple SD GothicNeo-SemiBold
                //Apple SD GothicNeo-Bold
                //no italic here
            case .Damascus:
                return Font(primaryFont: "Damascus")
                //Damascus
                //Damascus-SemiBold
                //Damascus-Bold
                //no italic here either
            }
            
            
        }
    }
    
    
    
    //    let Courier = [UIFont(name: "Courier", size: 14),
    //                   UIFont(name: "Courier-Italic", size: 14),
    //                   UIFont(name: "Courier-Bold", size: 17),
    //    ]
    //
    //    let Avenir = [UIFont(name: "Avenir-Book", size: 14),
    //                  UIFont(name: "Avenir-BlackOblique", size: 14),
    //                  UIFont(name: "Avenir-Black", size: 17)
    //    ]
    //
    //    let Georgia =  [UIFont(name: "Georgia", size: 14),
    //                    UIFont(name: "Georgia-Italic", size: 14),
    //                    UIFont(name: "Georgia-Bold", size: 17)
    //    ]
    //
    //    let Helvetica = [UIFont(name: "HelveticaNeue", size: 14),
    //                     UIFont(name: "HelveticaNeue-Italic", size: 14),
    //                     UIFont(name: "HelveticaNeue-Bold", size: 17)
    //    ]
    //
    //    let Verdana = [
    //        UIFont(name: "Verdana", size: 14),
    //        UIFont(name: "Verdana-Italic", size: 14),
    //        UIFont(name: "Verdana-Bold", size: 17)
    //
    //    ]
    //
    //    let TimesNewRoman = [
    //         UIFont(name: "TimesNewRomanPSMT", size: 14),
    //         UIFont(name: "TimesNewRomanPS-ItalicMT", size: 14),
    //         UIFont(name: "TimesNewRomanPS-BoldMT", size: 17)
    //    ]
    
    
    
    
enum AppTheme: Int, CaseIterable{
    case superNova = 0
    case darkPastel = 1
    case stormySea = 2
    case cloudySunset = 3
    
    
    var colors:Theme {
        switch self {
            //dark theme
        case .superNova:
            return  Theme(subjectColor: .russianViolet.withAlphaComponent(0.5),
                          topicColor: .spaceCadet.withAlphaComponent(0.5),
                          mapColor: .tyrianPurple.withAlphaComponent(0.3),
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
            //dark theme
        case .darkPastel:
            return Theme(subjectColor: .dpOxfordBlue.withAlphaComponent(0.4),
                         topicColor: .dpSpaceCadet.withAlphaComponent(0.6),
                         mapColor: .dpEnglishViolet.withAlphaComponent(0.6),
                         topColor: .dpWine.withAlphaComponent(0.5),
                         bottomColor: .dpTyrianPurple.withAlphaComponent(0.5),
                         fontColor: UIColor.white,
                         fontColorSecondary: .darkFontSecondary,
                         backGroundColor: .black,
                         primaryFont: FontManager.shared.primaryFont(style: .bold, size: 17),
                         secondaryFont: FontManager.shared.primaryFont(style: .semiBold, size: 14),
                         tertiaryFont: FontManager.shared.primaryFont(style: .italic, size: 14),
                         regularFont: FontManager.shared.primaryFont(style: .regular, size: 14)

                         
                         
            )
            //dark theme
        case.stormySea:
            return Theme(subjectColor: .oxfordBlue.withAlphaComponent(0.5),
                         topicColor: .iSprussianBlue.withAlphaComponent(0.5),
                         mapColor: .indigoDye.withAlphaComponent(0.5),
                         topColor:  .midNightGreen.withAlphaComponent(0.5),
                         bottomColor: .darkSlateGrey.withAlphaComponent(0.2) ,
                         fontColor: UIColor.white,
                         fontColorSecondary: .darkFontSecondary,
                         
                         backGroundColor: .black,
                         primaryFont: FontManager.shared.primaryFont(style: .bold, size: 17),
                         secondaryFont: FontManager.shared.primaryFont(style: .semiBold, size: 14),
                         tertiaryFont: FontManager.shared.primaryFont(style: .italic, size: 14),
                         regularFont: FontManager.shared.primaryFont(style: .regular, size: 14)

                         
            )
        case .cloudySunset:
            return Theme(subjectColor: .csDimGray,
                         topicColor: .csOldRose,
                         mapColor: .csSalmonPink,
                         topColor: .csMelon,
                         bottomColor: .csApricot,
                         fontColor: UIColor.black,
                         fontColorSecondary:.lightFontSecondary,
                         
                         backGroundColor: .white,
                         primaryFont: FontManager.shared.primaryFont(style: .bold, size: 17),
                         secondaryFont: FontManager.shared.primaryFont(style: .semiBold, size: 14),
                         tertiaryFont: FontManager.shared.primaryFont(style: .italic, size: 14),
                         regularFont: FontManager.shared.primaryFont(style: .regular, size: 14)

                         
            )
            
        }
        
        
        
    }
}

    

