//
//  SubjectViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/3/24.
//

import Foundation

struct SubjectViewModel{
    private var subject: Subject
    
    init(subject: Subject) {
        self.subject = subject
    }
    var id: UUID {
        subject.id ?? UUID()
    }
    
    var name: String{
        subject.title ?? ""
    }
    
    var createdOn: Date{
        subject.createdOn ?? Date()
    }
    var topicsCount: Int{
        subject.topics?.count ?? 0
        
    }
    var mapsCount: Int{
        subject.maps?.count ?? 0
        
    }
}
