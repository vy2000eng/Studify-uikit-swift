//
//  AddNewMapViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/7/24.
//

import Foundation


class AddNewMapViewModel{
    let subjectID: UUID
    init(subjectID: UUID) {
        self.subjectID = subjectID
    }
    
    func addMap(title:String){
        CoreDataManager.shared.addMapToSubject(title: title, subjectID: subjectID)
    }
    
}
