//
//  SubjectViewViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/3/24.
//

import Foundation
import UIKit


class SubjectListViewModel{
    var subjects = [SubjectViewModel]()
    
    var numberOfSubjects:Int{
        subjects.count
    }
    
    var background:UIColor{
        ColorManager.shared.currentTheme.colors.backGroundColor
    }
    
    var fontColor:UIColor{
        ColorManager.shared.currentTheme.colors.fontColor
    }
    
    init(){
        getAllSubjects()
    }
    
    func getAllSubjects(){
        let s = CoreDataManager.shared.getAllSubjects() ?? []
        subjects = s.map(SubjectViewModel.init)
    }
    
    func numberOfRows() -> Int{
        return numberOfSubjects
    }
    
    func subject(by index:Int) -> SubjectViewModel{
        subjects[index]
    }
 
    
    func deleteSubject(subject: SubjectViewModel){
        CoreDataManager.shared.deleteSubject(id: subject.id)
        getAllSubjects()
        
    }
}

