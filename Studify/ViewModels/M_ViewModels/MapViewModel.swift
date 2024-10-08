//
//  MapViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import Foundation
import UIKit


struct MapViewModel:Hashable{
    private var map:Maps
    
    init(map: Maps) {
        self.map = map
    }
    
    var id: UUID{
        map.id ?? UUID()
    }
    
    var title: String{
        map.title ?? ""
    }
    
    var createdOn:Date{
        map.createdOn ?? Date()
    }
    
//    var mindMapCount:Int{
//        map.mapSet?.count ?? 0
//    }
    
    var backGroundColor:UIColor{
        return ColorManager.shared.currentTheme.colors.mapColor
        
    }
    
    var fontColor:UIColor{
        return ColorManager.shared.currentTheme.colors.fontColor
    }
    var fontColorSecondary:UIColor{
        return ColorManager.shared.currentTheme.colors.fontColorSecondary
    }
    
    var titleFont:UIFont{
        ColorManager.shared.currentTheme.colors.primaryFont
    }
    var subtitleFont:UIFont{
        ColorManager.shared.currentTheme.colors.secondaryFont
    }
    

}
