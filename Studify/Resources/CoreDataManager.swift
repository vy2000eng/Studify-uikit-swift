//
//  CoreDataManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/2/24.
//

import Foundation
import CoreData


/**
 
 
 
 {"Tyrian purple":"5f0f40","Carmine":"9a031e","UT orange":"fb8b24","Spanish orange":"e36414","Midnight green":"0f4c5c"}
 
 
 */
//MARK: 5000 - create error
//MARK: 6000 - read error
//MARK: 7000 - update error
//MARK: 8000 - delete error





class CoreDataManager{
    static var shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
//    private init(inMemory: Bool = false) {
//            persistentContainer = NSPersistentContainer(name: "Subjects")
//            
//            if inMemory {
//                let description = NSPersistentStoreDescription()
//                description.type = NSInMemoryStoreType
//                persistentContainer.persistentStoreDescriptions = [description]
//            }
//            
//            persistentContainer.loadPersistentStores { (storeDescription, error) in
//                if let error = error as NSError? {
//                    fatalError("Unresolved error \(error), \(error.userInfo)")
//                }
//            }
//            persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
//        }
//    private init() {
//        persistentContainer = NSPersistentContainer(name: "Subjects")
//        persistentContainer.loadPersistentStores { _, error in
//            if let error = error as NSError? {
//                fatalError("Unresolved Error \(error), \(error.userInfo)")
//            }
//        }
//    }
    
    // This initializer is for testing purposes
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "Subjects")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved Error \(error), \(error.userInfo)")
            }
        }
    }
    
//    init(inMemory: Bool = false) {
//         persistentContainer = NSPersistentContainer(name: "Subjects")
//         if inMemory {
//             let description = NSPersistentStoreDescription()
//             description.type = NSInMemoryStoreType
//             persistentContainer.persistentStoreDescriptions = [description]
//         }
//         persistentContainer.loadPersistentStores { _, error in
//             if let error = error as NSError? {
//                 fatalError("Unresolved Error \(error), \(error.userInfo)")
//             }
//         }
//     }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
    //MARK: this is how u make db operation on a backlground thread
//    func addNewTopic(title: String, completion: @escaping (Result<Void, Error>) -> Void) {
//        performBackgroundTask { context in
//            let newTopic = Topic(context: context)
//            newTopic.topicTitle = title
//            newTopic.id = UUID()
//            newTopic.createdOn = Date()
//            
//            do {
//                try context.save()
//                DispatchQueue.main.async {
//                    completion(.success(()))
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
    //MARK: in the vc
//    func addNewTopic(title: String) {
//         coreDataManager.addNewTopic(title: title) { [weak self] result in
//             switch result {
//             case .success:
//                 print("Topic added successfully")
//                 self?.getAllTopics() // Refresh the topics list
//             case .failure(let error):
//                 print("Failed to add topic: \(error)")
//                 // Handle the error (e.g., show an alert to the user)
//             }
//         }
//     }

    
//    static func testInstance() -> CoreDataManager {
//           return CoreDataManager(inMemory: true)
       //}
    //    private init(){}
    //
    //    lazy var persistentContainer: NSPersistentContainer = {
    //        let container = NSPersistentContainer(name: "Subjects")
    //        container.loadPersistentStores { _, err  in
    //            if let err = err as NSError?{
    //                fatalError("Unresolved Error \(err), \(err.userInfo)")
    //            }
    //        }
    //        return container
    //    }()
    //
    //    var context: NSManagedObjectContext {
    //
    //        persistentContainer.viewContext
    //    }
    
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
    
    //    func addNewSubject(title: String, createdOn: Date){
    //        let newSubject = Subject(context: context)
    //        newSubject.title = title
    //        newSubject.id = UUID()
    //        newSubject.createdOn = createdOn
    //        newSubject.addedFirst = -1
    //        do{
    //            try context.save()
    //        }catch let error as NSError{
    //            print("Error adding a new subject: \(error.userInfo), \(error.localizedDescription)")
    //        }
    //    }
    
    
    
    
    
    func addNewTopic(title:String){
        //        let fetchRequest : NSFetchRequest<Subject> = Subject.fetchRequest()
        //        fetchRequest.predicate = NSPredicate(format: "id=%@", subjectID.uuidString)
        let newTopic = Topic(context: context)
        newTopic.topicTitle = title
        newTopic.id = UUID()
        newTopic.createdOn = Date()
        do{
            //            let subject = try context.fetch(fetchRequest).first
            //            subject?.addToTopics(newTopic)
            //            newTopic.subject = subject
            try context.save()
        }catch let error as NSError{
            print("Error deleting subject: \(error.userInfo), \(error.localizedDescription)")
        }
    }
    
    func addMapToSubject(title: String, subjectID:UUID){
        //        let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
        //        fetchRequest.predicate = NSPredicate(format: "id=%@",subjectID.uuidString)
        
        let newMap = Maps(context: context)
        newMap.title = title
        newMap.id = UUID()
        newMap.createdOn = Date()
        
        do{
            //            let subject = try context.fetch(fetchRequest).first
            //            subject?.addToMaps(newMap)
            //            newMap.subject = subject
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
        newflashCard.learned = false
        newflashCard.stillLearning = true
        do{
            let topic = try context.fetch(fetchRequest).first
            topic?.addToFlashcardset(newflashCard)
            newflashCard.topic = topic
            try context.save()
        }catch let error as NSError{
            print("Error add new flashcard: \(error.userInfo) , \(error.localizedDescription)")
        }
        
    }
    
    // MARK: - read  functions
    
    //    func getOpenedFirst(subjectID: UUID)->Int16{
    //        let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    //        fetchRequest.predicate = NSPredicate(format: "id=%@", subjectID.uuidString)
    //
    //        do{
    //            let subject =  try context.fetch(fetchRequest)
    //            return  subject.first!.addedFirst          //  context.delete((subject.first)!)
    //
    //        }catch let error as NSError{
    //            print("Error retrieving openedFirst subject: \(error.userInfo), \(error.localizedDescription)")
    //            return -2
    //        }
    //
    //
    //    }
    
    //    func getAllSubjects() -> [Subject]?{
    //        do{
    //            return try  context.fetch(Subject.fetchRequest())
    //        }catch let error as NSError{
    //            print("Error fetching all subjects: \(error.userInfo), \(error.localizedDescription)")
    //            return nil
    //        }
    //    }
    
    func getAllTopics() ->[Topic]{
        
        let fetchRequest: NSFetchRequest<Topic> = Topic.fetchRequest()
        //fetchRequest.predicate = NSPredicate(format: "subject.id == %@", subjectid.uuidString )
        
        do {
            let topics = try context.fetch(fetchRequest)
            return topics
        } catch let error as NSError{
            print("Error fetching topics for subject ID \(error.userInfo): \(error.localizedDescription)")
            return []  // Return an empty array if the fetch fails
        }
    }
    
    //    func getAllMapsForSubject(subjectid: UUID) -> [Maps]{
    //
    //        let fetchRequest: NSFetchRequest<Maps> = Maps.fetchRequest()
    //        fetchRequest.predicate = NSPredicate(format: "subject.id == %@", subjectid.uuidString )
    //        do {
    //            let maps = try context.fetch(fetchRequest)
    //            return maps
    //        } catch {
    //            print("Error fetching maps for subject ID \(subjectid): \(error)")
    //            return []  // Return an empty array if the fetch fails
    //        }
    //    }
    
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
    //MARK: - Update Functions
    func updateFlashcard(flashcardID: UUID, front: String, back:String){
        let fetchRequest: NSFetchRequest<FlashCard> = FlashCard.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", flashcardID.uuidString)
        do{
            let flashcard = try context.fetch(fetchRequest).first
            flashcard?.front = front
            flashcard?.back = back
            try context.save()
        }catch let error as NSError{
            print("Error updating FlashCard: \(error.userInfo), \(error.localizedDescription)")
        }
    }
    func toggleLearned(flashcardID:UUID){
        let fetchRequest: NSFetchRequest<FlashCard> = FlashCard.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", flashcardID.uuidString)
        do{
            let flashcard = try context.fetch(fetchRequest).first(where: {$0.id == flashcardID})
            flashcard?.learned = !flashcard!.learned
            flashcard?.stillLearning = !flashcard!.stillLearning
            
            try context.save()
            
            
        }catch let error as NSError{
            print("Error updating FlashCard: \(error.userInfo), \(error.localizedDescription)")
        }
    }
    
    func toggleStillLearning(flashcardID:UUID){
        let fetchRequest: NSFetchRequest<FlashCard> = FlashCard.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", flashcardID.uuidString)
        do{
            let flashcard = try context.fetch(fetchRequest).first(where: {$0.id == flashcardID})
            flashcard?.stillLearning = !flashcard!.stillLearning
            flashcard?.learned = !flashcard!.learned
            
            try context.save()
            
            
        }catch let error as NSError{
            print("Error updating FlashCard: \(error.userInfo), \(error.localizedDescription)")
        }
    }
    func updateTopic(topicID: UUID, title: String){
        let fetchRequest:NSFetchRequest<Topic> = Topic.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", topicID as CVarArg)
        
        do{
            guard let topic = try context.fetch(fetchRequest).first else {
                throw NSError(domain: "CoreDataManager", code: 6000, userInfo: [NSLocalizedDescriptionKey: "Topic not found"])
            }
            topic.topicTitle = title
            try context.save()
            
            
        }catch let error as NSError{
            print("Error updating Topic: \(error.userInfo), \(error.localizedDescription)")

            
            
        }
    }
    
    //    func setOpenedFirst(subjectID:UUID, addedFirst:Int16){
    //        let fetchRequest : NSFetchRequest<Subject> = Subject.fetchRequest()
    //        fetchRequest.predicate = NSPredicate(format: "id=%@", subjectID.uuidString)
    //        do{
    //            let subject =  try context.fetch(fetchRequest)
    //            subject.first?.addedFirst = addedFirst
    //            try context.save()
    //
    //        }catch let error as NSError{
    //            print("Error updating openedFirst in subject: \(error.userInfo), \(error.localizedDescription)")
    //        }
    //    }
    
    
    // MARK: - delete  functions
    
    //    func deleteSubject(id: UUID){
    //        let fetchRequest : NSFetchRequest<Subject> = Subject.fetchRequest()
    //        fetchRequest.predicate = NSPredicate(format: "id=%@", id.uuidString)
    //        do{
    //            let subject =  try context.fetch(fetchRequest)
    //            context.delete((subject.first)!)
    //            try context.save()
    //
    //        }catch let error as NSError{
    //            print("Error deleting subject: \(error.userInfo), \(error.localizedDescription)")
    //        }
    //
    //    }
    
    func deleteTopic( topicID: UUID){
        let fetchRequest: NSFetchRequest<Topic> = Topic.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id==%@", topicID as CVarArg)
        do{
            //let topic = try context.fetch(fetchRequest)
            guard let topic = try context.fetch(fetchRequest).first else {
                throw NSError(domain: "CoreDataManager", code: 8000, userInfo: [NSLocalizedDescriptionKey: "Topic not found"])
            }
            context.delete(topic)
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
