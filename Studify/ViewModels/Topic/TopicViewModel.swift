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
        topic.id ?? UUID()
        
    }
    var title: String{
        topic.topicTitle ?? ""
        
    }
    var createdOn:Date{
        topic.createdOn ?? Date()
    }
    
    var topicCount:Int{
        topic.flashcardset?.count ?? 0
    }
  //  private var flashcardSet:[FlashCar]
    
//    private var flashCardSet: FlashCardSet
//    
//    init(flashCardSet: FlashCardSet) {
//        self.flashCardSet = flashCardSet
//    }
//    
//    var id: UUID{
//        flashCardSet.id ?? UUID()
//    }
//    
//    var name: String{
//        flashCardSet.title ?? ""
//    }
//    
//    var flashcardSets: [FlashCardSet]{
//        [flashCardSet]
//
//        
//        
//    }
    
    
    
    
    
    
    
    
    
}
