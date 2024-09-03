//
//  CoreDataTests.swift
//  StudifyTests
//
//  Created by VladyslavYatsuta on 8/31/24.
//
import XCTest
import CoreData
@testable import Studify

public extension NSManagedObject {

    convenience init(usedContext: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: usedContext)!
        self.init(entity: entity, insertInto: usedContext)
    }
}

class TopicCoreDataTests:XCTestCase{
    
    var coreDataManager: CoreDataManager!
    
    override func setUpWithError() throws {
        super.setUp()
        
        // Create an in-memory Core Data stack for testing
        coreDataManager = CoreDataManager(inMemory: true)
        
        // Replace the shared instance with our test instance
        CoreDataManager.shared = coreDataManager
    }
    
    override func tearDownWithError() throws {
        coreDataManager = nil
        super.tearDown()
    }
    

    
    
    func testSaveContext() throws {
        //let new = Topic(entity: NSEntityDescription(), insertInto: coreDataManager.context)
        let newTopic = Topic(context: coreDataManager.context)
        newTopic.id = UUID()
        newTopic.createdOn = Date()
        newTopic.topicTitle = "Test Topic"
        
        coreDataManager.saveContext()
        let fetchRequest : NSFetchRequest<Topic> = Topic.fetchRequest()
        let fetchedTopics = try coreDataManager.context.fetch(fetchRequest)
        XCTAssertEqual(fetchedTopics.count, 1)
        XCTAssertEqual(fetchedTopics.first?.topicTitle, "Test Topic")
        
        
        
    }
    
    func testContextHasChanges() throws {
        // Given
        let topic = Topic(context: coreDataManager.context)
        topic.id = UUID()
        topic.createdOn = Date()
        topic.topicTitle = "Test Topic"
        
        // When
        XCTAssertTrue(coreDataManager.context.hasChanges)
        
        // Then
        coreDataManager.saveContext()
        XCTAssertFalse(coreDataManager.context.hasChanges)
    }
    
    func createTopic(topicTitle:String)->Topic{
        let newTopic = Topic(context: coreDataManager.context)
        newTopic.id = UUID()
        newTopic.createdOn = Date()
        newTopic.topicTitle = topicTitle
        return newTopic
        
    }
    
    func testFetchFromContext() throws{
        let topicOne = createTopic(topicTitle: "Topic 1")
        let topicTwo = createTopic(topicTitle: "Topic 2")
        
        coreDataManager.saveContext()
        
        let fetchRequest: NSFetchRequest<Topic> = Topic.fetchRequest()
        let fetchedTopics = try coreDataManager.context.fetch(fetchRequest)
        
        XCTAssertEqual(fetchedTopics.count, 2)
        XCTAssertTrue(fetchedTopics.contains(where: { $0.topicTitle == topicOne.topicTitle }))
        XCTAssertTrue(fetchedTopics.contains(where: { $0.topicTitle == topicTwo.topicTitle }))
    }
    
    func testAddNewTopic() throws{
        let numberOfTopics = 10
        for i in 1...numberOfTopics{
            coreDataManager.addNewTopic(title: "Test Topic \(i)")
            
        }
        
        let fetchRequest:NSFetchRequest<Topic> = Topic.fetchRequest()
        let fetchedTopics = try coreDataManager.context.fetch(fetchRequest)
        XCTAssertEqual(fetchedTopics.count, numberOfTopics, "There should be \(numberOfTopics) topics")

        let expectedTitles = Set((1...numberOfTopics).map { "Test Topic \($0)" })

        let fetchedTitles = Set(fetchedTopics.map { $0.topicTitle })
        XCTAssertEqual(fetchedTitles, expectedTitles, "All expected topic titles should be present")
        
    }
    
    func testGetAllTopics() throws{
        let numberOfTopics = 50
        for i in 1...numberOfTopics{
            coreDataManager.addNewTopic(title: "Test Topic \(i)")
            
        }
        let topics = coreDataManager.getAllTopics()
        
        XCTAssertEqual(topics.count, numberOfTopics)
    }

    
    
    
    func testDeleteTopic() throws{
        let numberOfTopics = 10
        for i in 1...numberOfTopics{
            coreDataManager.addNewTopic(title: "Test Topic \(i)")
            
        }
        let fetchRequest:NSFetchRequest<Topic> = Topic.fetchRequest()
        var fetchedTopics = try coreDataManager.context.fetch(fetchRequest)
        XCTAssertEqual(fetchedTopics.count, numberOfTopics, "There should be \(numberOfTopics) topics")

        for i in 0..<numberOfTopics {
              // Fetch topics at the start of each iteration
              fetchedTopics = try coreDataManager.context.fetch(fetchRequest)
              
              guard let topicId = fetchedTopics.first?.id else {
                  XCTFail("No topics left to delete")
                  return
              }
              
              coreDataManager.deleteTopic(topicID: topicId)
              
              // Fetch again to get the updated count
              fetchedTopics = try coreDataManager.context.fetch(fetchRequest)
              let expectedCount = numberOfTopics - (i + 1)
              XCTAssertEqual(fetchedTopics.count, expectedCount, "There should be \(expectedCount) topics after deleting \(i + 1) topics")
          }
        
        for i in 1...numberOfTopics{
            coreDataManager.addNewTopic(title: "Test Topic \(i)")
        }
        fetchedTopics = try coreDataManager.context.fetch(fetchRequest)
        let nonExistentUUID = UUID()
        coreDataManager.deleteTopic(topicID: nonExistentUUID)
        fetchedTopics = try coreDataManager.context.fetch(fetchRequest)
        XCTAssertEqual(fetchedTopics.count, numberOfTopics, "Number of topics should still be unchanged")

        
        
        
        
    }
    
    //This test is jus for updating the topicTitle
    func testUpdateTopic() throws {
        let numberOfTopics = 10
        for i in 1...numberOfTopics{
            coreDataManager.addNewTopic(title: "Test Topic \(i)")
            
        }
        
        let fetchRequest:NSFetchRequest<Topic> = Topic.fetchRequest()
        var fetchedTopics = try coreDataManager.context.fetch(fetchRequest)
        XCTAssertEqual(fetchedTopics.count, numberOfTopics, "There should be \(numberOfTopics) topics")
        
        
        for topic in fetchedTopics{
            
            coreDataManager.updateTopic(topicID: topic.id, title: "Updated Test Topic")
        }
        
        fetchedTopics = try coreDataManager.context.fetch(fetchRequest)
        
        for topic in fetchedTopics {
            XCTAssertEqual(topic.topicTitle, "Updated Test Topic", "All topics should have updated title")
        }
        
        let nonExistentID = UUID()
        coreDataManager.updateTopic(topicID: nonExistentID, title: "This should fail silently")
        
        // Verify that no new topic was created
        fetchedTopics = try coreDataManager.context.fetch(fetchRequest)
        XCTAssertEqual(fetchedTopics.count, numberOfTopics, "Number of topics should still be unchanged")
    }

    
    
    
}
