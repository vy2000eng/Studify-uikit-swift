//
//  TopicViewModelTests.swift
//  StudifyTests
//
//  Created by VladyslavYatsuta on 8/31/24.
//

import XCTest
import CoreData
@testable import Studify

final class TopicViewModelTests: XCTestCase {
    
    
    var coreDataManager: CoreDataManager!
    var sut: TopicViewController!
    
    override func setUpWithError() throws {
        super.setUp()
        
        // Create an in-memory Core Data stack for testing
        coreDataManager = CoreDataManager(inMemory: true)
        
        // Replace the shared instance with our test instance
        CoreDataManager.shared = coreDataManager
     
    }
    
    override func tearDownWithError() throws {
        coreDataManager = nil
        sut = nil
        super.tearDown()
    }
    
    func testTestedTMVminit(){
        let viewModel = TopicMapViewModel()
        
        XCTAssertTrue(viewModel.numberOfTopics == 0)
        XCTAssertTrue(viewModel.sectionsCount == 0)
        XCTAssertTrue(viewModel.topics.count == 0)
        
        XCTAssertTrue(viewModel.numberOfTopics == 0)
        XCTAssertTrue(viewModel.sectionsCount == 0)
        XCTAssertTrue(viewModel.topics.count == 0)
        
        
        XCTAssertThrowsError(try viewModel.numberOfRows(by: 0)) { error in
            XCTAssertEqual((error as NSError).domain, "EmptySectionsError")
            XCTAssertEqual((error as NSError).code, 2)
            XCTAssertEqual((error as NSError).localizedDescription, "No sections available")
        }
        
        XCTAssertThrowsError(try viewModel.numberOfRows(by: 25)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidSectionError")
            XCTAssertEqual((error as NSError).code, 1)
            XCTAssertEqual((error as NSError).localizedDescription, "Invalid section index")
        }
        
    }
    
    
    func testViewModelInitialization() throws{
        let viewModel = TopicMapViewModel()
        
        XCTAssertTrue(viewModel.numberOfTopics == 0)
        XCTAssertTrue(viewModel.sectionsCount == 0)
        XCTAssertTrue(viewModel.topics.count == 0)
        
        
        XCTAssertThrowsError(try viewModel.numberOfRows(by: 0)) { error in
            XCTAssertEqual((error as NSError).domain, "EmptySectionsError")
            XCTAssertEqual((error as NSError).code, 2)
            XCTAssertEqual((error as NSError).localizedDescription, "No sections available")
        }
        
        XCTAssertThrowsError(try viewModel.numberOfRows(by: 25)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidSectionError")
            XCTAssertEqual((error as NSError).code, 1)
            XCTAssertEqual((error as NSError).localizedDescription, "Invalid section index")
        }
        coreDataManager.addNewTopic(title: "Test Topic")
        viewModel.getAllTopics()

        viewModel.sections.append(Sections(header: "topics", data: .topics(viewModel.topics)))
        XCTAssertTrue(viewModel.numberOfTopics == 1)
        XCTAssertTrue(viewModel.sectionsCount == 1)
        viewModel.toggleSection(0)
        XCTAssertFalse(viewModel.isSectionCollapsed(0))


    }
    

    //MARK: ViewController Tests
    func testViewControllerCrudOperations(){
        let expectedCount = 10
        for i in 1...expectedCount{
            coreDataManager.addNewTopic(title: "Test Topic \(i)")
            
        }
        var fetchedTopics: [Topic]
        fetchedTopics = coreDataManager.getAllTopics()
        
        XCTAssertEqual(fetchedTopics.count, expectedCount, "There should be \(expectedCount) topics")
        
        sut = TopicViewController()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.viewmodel.sectionsCount, 1)
        XCTAssertEqual(sut.viewmodel.isSectionCollapsed(0), true)
        
        XCTAssertEqual(sut.viewmodel.numberOfTopics, expectedCount)
        XCTAssertEqual(sut.viewmodel.topics.count, expectedCount)
        
        sut.handleCollapseButton(UIButton())
        XCTAssertEqual(sut.viewmodel.isSectionCollapsed(0), false)
        XCTAssertTrue(sut.viewmodel.numberOfTopics == expectedCount)
        XCTAssertTrue(sut.viewmodel.sectionsCount == 1)
        XCTAssertTrue(sut.viewmodel.topics.count == expectedCount)
        XCTAssertTrue(sut.viewmodel.topics.count == expectedCount)
        sut = nil
    }
    
    

    
    func testViewControllerInit(){
        sut = TopicViewController()
        sut.loadViewIfNeeded()
        
        XCTAssertTrue(sut.viewmodel.numberOfTopics == 0)
        XCTAssertTrue(sut.viewmodel.sectionsCount == 0)
        XCTAssertTrue(sut.viewmodel.topics.count == 0)
        XCTAssertNil(sut.updateTopicAndMapCountInSubjectCollectionViewDelegate)
        
        
        XCTAssertThrowsError(try sut.viewmodel.numberOfRows(by: 0)) { error in
            XCTAssertEqual((error as NSError).domain, "EmptySectionsError")
            XCTAssertEqual((error as NSError).code, 2)
            XCTAssertEqual((error as NSError).localizedDescription, "No sections available")
        }
        
        XCTAssertThrowsError(try sut.viewmodel.numberOfRows(by: 25)) { error in
            XCTAssertEqual((error as NSError).domain, "InvalidSectionError")
            XCTAssertEqual((error as NSError).code, 1)
            XCTAssertEqual((error as NSError).localizedDescription, "Invalid section index")
        }
        sut = nil
        
        
        func testTestedTMVMdeleteTopic(){
            let expectedCount = 10
            for i in 1...expectedCount{
                coreDataManager.addNewTopic(title: "Test Topic \(i)")
                
            }
            var fetchedTopics: [Topic]
            fetchedTopics = coreDataManager.getAllTopics()
            
            XCTAssertEqual(fetchedTopics.count, expectedCount, "There should be \(expectedCount) topics")
            
            sut = TopicViewController()
            sut.loadViewIfNeeded()
            let topics = CoreDataManager.shared.getAllTopics().map(TopicViewModel.init)

            for (index, topic) in topics.enumerated(){
                XCTAssertEqual(topic, sut.viewmodel.topic(by:index ))
            }
            
            for i in 1...expectedCount{
                sut.viewmodel.deleteTopic(topic: sut.viewmodel.topic(by: 0))
                
                let newExpectedCount = expectedCount-i
                XCTAssertEqual(newExpectedCount, sut.viewmodel.numberOfTopics)
                
            }
            sut = nil
        }
    }
    
    func testDataSource(){
        sut = TopicViewController()

        XCTAssertEqual(sut.viewmodel.sectionsCount, 0)
        coreDataManager.addNewTopic(title: "Test Topic")
        sut.viewmodel.getAllTopics()
        let topicSection =  Sections(header: "Topics", data: .topics(sut.viewmodel.topics))
        sut.viewmodel.sections.append(topicSection)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.viewmodel.sectionsCount, 1)

        let numberOfSections = sut.numberOfSections(in: sut.collectionView)
        XCTAssertEqual(numberOfSections, 1)

        let numberOfItemsInSection  = sut.collectionView(sut.collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfItemsInSection, 1)
        
        let cellForItemAt = sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(cellForItemAt)

        let headerView = sut.collectionView(sut.collectionView, viewForSupplementaryElementOfKind:UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(headerView)
        
        sut = nil
        
    }
    
    
    func testHandleFirstInsertion(){

        sut = TopicViewController()
        sut.loadViewIfNeeded()
        
        
        
        coreDataManager.addNewTopic(title: "test topic")
        //sut.viewmodel.getAllTopics()
        //XCTAssertEqual(sut.viewmodel.topics.count, 1)
        
        sut.testHandleFirstInsertion(type: .topics)
      
 


 
    }
}
