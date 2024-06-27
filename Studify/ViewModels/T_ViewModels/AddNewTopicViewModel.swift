//
//  AddNewTopicViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/7/24.
//

import Foundation

class AddNewTopicViewModel{
    let subjectId: UUID
    
    init(subjectId: UUID) {
        self.subjectId = subjectId
    }
    
    
    func addTopic(title: String ){
        CoreDataManager.shared.addTopicToSubject(title: title, subjectID: subjectId)
    }
}
