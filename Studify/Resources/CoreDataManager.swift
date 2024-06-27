//
//  CoreDataManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/2/24.
//

import Foundation
import CoreData


class CoreDataManager{
    static let shared = CoreDataManager()
    
    private init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Subjects")
        container.loadPersistentStores { _, err  in
            if let err = err as NSError?{
                fatalError("Unresolved Error \(err), \(err.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        
        persistentContainer.viewContext
    }
    
    func saveContext(){
        if context.hasChanges{
            do{
                try context.save()
            }catch let error as NSError{
                print("Error saving the staged changes \(error), \(error.userInfo)")
            }
        }
    }
    // MARK: - create functions
    
    func addNewSubject(title: String, createdOn: Date){
        let newSubject = Subject(context: context)
        newSubject.title = title
        newSubject.id = UUID()
        newSubject.createdOn = createdOn
        
        do{
            try context.save()
            
        }catch let error as NSError{
            print("Error adding a new subject: \(error.userInfo), \(error.localizedDescription)")
        }
    }
    
    func addTopicToSubject(title:String, subjectID:UUID){
        let fetchRequest : NSFetchRequest<Subject> = Subject.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@", subjectID.uuidString)
        
        let newTopic = Topic(context: context)
        newTopic.topicTitle = title
        newTopic.id = UUID()
        newTopic.createdOn = Date()
        
        do{
            let subject = try context.fetch(fetchRequest).first
            subject?.addToTopics(newTopic)
            newTopic.subject = subject
            try context.save()
        }catch let error as NSError{
            print("Error deleting subject: \(error.userInfo), \(error.localizedDescription)")
        }
        
    }
    
    func addMapToSubject(title: String, subjectID:UUID){
        let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@",subjectID.uuidString)
        
        let newMap = Maps(context: context)
        newMap.title = title
        newMap.id = UUID()
        newMap.createdOn = Date()
        
        do{
            let subject = try context.fetch(fetchRequest).first
            subject?.addToMaps(newMap)
            newMap.subject = subject
            try context.save()
        }catch let error as NSError{
            print("Error add new map: \(error.userInfo) , \(error.localizedDescription)")
            
        }
    }
    
    func addflashCardToTopic(front: String, back:String, topicID:UUID){
        
        let fetchRequest: NSFetchRequest<Topic> = Topic.fetchRequest()
        fetchRequest.predicate = NSPredicate(format:"id=%@", topicID.uuidString)
        
        let newflashCard = FlashCard(context: context)
        newflashCard.id = UUID()
        newflashCard.front = front
        newflashCard.back = back
       // newflashCard.topic
        
        do{
            let topic = try context.fetch(fetchRequest).first
            topic?.addToFlashcardset(newflashCard)
            newflashCard.topic = topic
            try context.save()
            
        }catch let error as NSError{
            print("Error add new flashcard: \(error.userInfo) , \(error.localizedDescription)")

            
        }
        
//        let fetchRequest:NSFetchRequest<Topic> = Topic.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id=%@", topicID.uuidString)
//        let flashcard = FlashCard(context: context)
//        flashcard.id = UUID()
//        flashcard.front = front
//        flashcard.back = back
//        
//        do{
//            let topic = try context.fetch(fetchRequest)
//            topic.first?.flashcardset?.append(flashcard)
//            flashcard.topic = topic.first
//            try context.save()
//            
//        }catch let error as NSError{
//            
//            print("Error add new flashcard: \(error.userInfo), \(error.localizedDescription)")
//            
//        }
        
    }
    
    // MARK: - read  functions

    func getAllSubjects() -> [Subject]?{
        do{
            return try  context.fetch(Subject.fetchRequest())
        }catch let error as NSError{
            print("Error fetching all subjects: \(error.userInfo), \(error.localizedDescription)")
            return nil
        }
    }
    
    func getAllTopicsForSubject(subjectid: UUID) ->[Topic]{

        let fetchRequest: NSFetchRequest<Topic> = Topic.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "subject.id == %@", subjectid.uuidString )

         do {
             let topics = try context.fetch(fetchRequest)
             return topics
         } catch {
             print("Error fetching topics for subject ID \(subjectid): \(error)")
             return []  // Return an empty array if the fetch fails
         }
    }
    
    func getAllMapsForSubject(subjectid: UUID) -> [Maps]{
        
        let fetchRequest: NSFetchRequest<Maps> = Maps.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "subject.id == %@", subjectid.uuidString )
        do {
            let maps = try context.fetch(fetchRequest)
            return maps
        } catch {
            print("Error fetching maps for subject ID \(subjectid): \(error)")
            return []  // Return an empty array if the fetch fails
        }
        
    }
    
    func getAllFlashCardsForTopic(topicID: UUID) -> [FlashCard]{
        let fetchRequest: NSFetchRequest<FlashCard> = FlashCard.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "topic.id == %@", topicID.uuidString)
        do{
            let flashcards = try context.fetch(fetchRequest)
            return flashcards
            
        }catch{
            print("Error fetching maps for subject ID \(topicID): \(error)")
            return []
            
        }
        
    }
    //Update Functions
    func updateFlashcard(flashcardID: UUID, front: String, back:String){
        let fetchRequest: NSFetchRequest<FlashCard> = FlashCard.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "flashcard.id == %@", flashcardID.uuidString)
        do{
            var flashcard = try context.fetch(fetchRequest).first
            flashcard?.front = front
            flashcard?.back = back
            try context.save()
            
        }catch let err as NSError{
            
        }
        

    }
    

    // MARK: - delete  functions

    func deleteSubject(id: UUID){
        let fetchRequest : NSFetchRequest<Subject> = Subject.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@", id.uuidString)
        do{
             let subject =  try context.fetch(fetchRequest)
            context.delete((subject.first)!)
            try context.save()
            
        }catch let error as NSError{
            print("Error deleting subject: \(error.userInfo), \(error.localizedDescription)")
        }
        
    }
    
    func deleteTopic( topicID: UUID){
        let fetchRequest: NSFetchRequest<Topic> = Topic.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@", topicID.uuidString)
        do{
            let topic = try context.fetch(fetchRequest)
            context.delete((topic.first)!)
            try context.save()
    
            
        }catch let error as NSError{
            print("Error deleting topic: \(error.userInfo), \(error.localizedDescription)")
        }
        
        
    }
    
    func deleteMap(mapID: UUID){
        let fetchRequest: NSFetchRequest<Maps> = Maps.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@", mapID.uuidString)
        do{
            let map = try context.fetch(fetchRequest)
            context.delete(map.first!)
            try context.save()
            
        }catch let error as NSError{
            print("Error deleting map: \(error.userInfo), \(error.localizedDescription)")

            
        }
        
        
    }
    
    func deleteFlashCard(flashCardID: UUID){
        let fetchRequest:NSFetchRequest<FlashCard> = FlashCard.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@", flashCardID.uuidString)
        
        do{
            
            let flashcard = try context.fetch(fetchRequest)
            context.delete(flashcard.first!)
            try context.save()
            
            
        }catch let error as NSError{
            print("Error deleting flashcard: \(error.userInfo), \(error.localizedDescription)")
        }
        
        
        
    }
    
    
    
    
    

    
    
}
//
//    // create functions
//    
//    
//    //Mark :-
//    //read functions
//    //get all subjects, flashcards, and maps
//    func getAllSubjects() -> [Subject]{
//        var subjects = [Subject]()
//        let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
//        
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdOn", ascending: true)]
//        do{
//            
//            return try context.fetch(fetchRequest)
//        }catch let error as NSError{
//            print(error.localizedDescription)
//            return []
//        }
//    }
//    
//    func getSubjectById(id: UUID) -> Subject? {
//        let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id=%@", id.uuidString)
//        do{
//            let subjects = try context.fetch(fetchRequest)
//            
//            return subjects.first(where: {$0.id == id})
//            
//        }catch let error as NSError{
//            print("Error fetching subject with id: \(error.userInfo), \(error.localizedDescription)")
//            return nil
//        }
//    }
//    
//    
//    
//    func getAllFlashCardSetsWithInASubject(subjectId : UUID) -> FlashCardSet?{
//
//        let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id=%@", subjectId.uuidString)
//        
//        do{
//            let subjects = try context.fetch(fetchRequest)
//            return subjects.first?.flashcardsets
////            if let subject = subjects.first{
////                
////                return subject.flashcardsets
////                
////            }
//            //return subject.first?.flashcardsets
//        }catch let error as NSError{
//            print("Error fetching flashcards with in a particular subject: \(error.userInfo), \(error.localizedDescription)")
//            return nil
//        }
//        
//    }
    
    
    
    // update functions
    // delete functions
    
    
    
    
//}
