//
//  SubjectDetailsViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/5/24.
//

import Foundation
class TopicMapViewModel{

    var subjectID: UUID
    var collapsedSections: [Bool]

    var topics = [TopicViewModel]()
    var maps = [MapViewModel]()
    //var isRowSectionCollapsed = false
    
    
    var numberOfTopics:Int{
        topics.count
    }
    var numberOfMaps:Int{
        maps.count
    }
    init(subjectID: UUID,sectionsCount: Int) {
        self.subjectID = subjectID
        self.collapsedSections = Array(repeating: false, count: sectionsCount)
        getAllTopics()
        getAllMaps()
    }
    
    func toggleSection(_ section: Int) {
           collapsedSections[section].toggle()
    }
    
    func isSectionCollapsed(_ section: Int) -> Bool {
           return collapsedSections[section]
    }
    
    //MARK: TODO number of row topics

    func numberOfRowsForTopics() -> Int{
        return numberOfTopics
    }
    //MARK: TODO number of row maps
    func numberOfRowsForMaps()-> Int{
        return numberOfMaps
    }
    
    func numberOfRows(by section: Int)->Int{
        if section == 0{
            return collapsedSections[section] ?
            0 : numberOfRowsForTopics()
        }else{
            return collapsedSections[section] ?
            0 : numberOfRowsForMaps() 
           // return numberOfRowsForMaps()
        }
    }
    
    func topic(by index:Int) ->TopicViewModel{
        topics[index]
    }
    
    func map(by index:Int) ->MapViewModel{
         maps[index]
    }
    
    
    
    func insertTopic(title: String, id: UUID){
        CoreDataManager.shared.addTopicToSubject(title:title,subjectID: subjectID)
        
    }
    
    //MARK: read
    func getAllMaps(){
        maps = CoreDataManager.shared.getAllMapsForSubject(subjectid: subjectID).map(MapViewModel.init)
        print(maps.count)
    }
    
    
    func getAllTopics(){
        topics = CoreDataManager.shared.getAllTopicsForSubject(subjectid: subjectID).map(TopicViewModel.init)
        print(topics.count)
    }
    
    //MARK: delete
    
    func deleteTopic(topic:TopicViewModel){
        CoreDataManager.shared.deleteTopic(topicID: topic.id)
        getAllTopics()
        print("delete Topic called \(topics.count)")
    }
    
    func deleteMap(map: MapViewModel){
        CoreDataManager.shared.deleteMap(mapID:map.id)
        getAllMaps()
        print("delete map called \(maps.count)")
    }
}
