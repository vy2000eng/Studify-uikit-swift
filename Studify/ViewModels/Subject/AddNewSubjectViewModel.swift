//
//  AddNewSubjectViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/3/24.
//

import Foundation

class AddNewSubjectViewModel{
    func addSubject(title:String, createdOn: Date){
        CoreDataManager.shared.addNewSubject(title: title, createdOn:createdOn)
    }
}
