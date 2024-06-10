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
        //subject.topics?.?.count ?? -1
        
    }
    var mapsCount: Int{
        subject.maps?.count ?? 0
        //subject.topics?.?.count ?? -1
        
    }
//    var topics: Topic{
//        let topic = Topic()
//        subject.topics = topic
//        
//    }
//
//    var topics: [Topic]{
//        
//        
//        
//    }
    
//    var topics:[[FlashCard]]{
//        
//    }
//
//    var flashCardSet: FlashCardSet{
//        var flashcardSet = FlashCardSet()
//        flashcardSet.subject = subject
//        
////        guard let flashcardsSet = subject.flashCardSet.flashcards else {
////              return FlashCardSet(flashcards: [])
////          }
////          let flashcards = flashcardsSet.array as? [Flashcard] ?? []
////          return FlashCardSet(flashcards: flashcards)
////        //subject.flashcardsets as FlashCardSet
//        //subject.flashcardsets ?? FlashCardSet()
//        
//    }
//    
  
//    var maps: MindMap{
//
//    }
    
    
//    var completedOn: Date{
//        task.completedOn ?? Date()
//    }
//    
//    var completed:Bool{
//        task.completed
//    }
    
    
    
    
    
    
    
}
