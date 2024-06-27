//
//  AddNewFlashCardViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import Foundation

class AddNewFlashCardViewModel{
    let topicID: UUID
    
    init(topicID: UUID) {
        self.topicID = topicID
    }
    
    func addFlashcard(front:String, back:String){
        CoreDataManager.shared.addflashCardToTopic(front: front, back: back, topicID: topicID)
    }
    
    
    
}
