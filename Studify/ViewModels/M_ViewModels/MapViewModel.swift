//
//  MapViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import Foundation


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
    
    var mindMapCount:Int{
        map.mapSet?.count ?? 0
    }
    
    
    
    
    
}
