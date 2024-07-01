//
//  FlashCardSetViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/5/24.
//

import Foundation


struct TopicViewModel:Hashable{
    private var topic: Topic
    
    init(topic: Topic) {
        self.topic = topic
    }
    
    var id: UUID{
        topic.id
        
    }
    var title: String{
        topic.topicTitle
        
    }
    var createdOn:Date{
        topic.createdOn
    }
    
    var topicCount:Int{
        topic.flashcardset?.count ?? 0
    }

    
    
    
    
    
    
    
    
    
}
