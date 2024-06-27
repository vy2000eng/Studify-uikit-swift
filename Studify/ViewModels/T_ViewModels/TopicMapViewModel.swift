//
//  SubjectDetailsViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/5/24.
//
enum sectionData{
    case topics([TopicViewModel])
    case maps([MapViewModel])
}

class Sections{
    let header: String
    let data: sectionData
    var isOpened: Bool = true
    
    init(header: String, data: sectionData, isOpened: Bool = true ) {
        self.header = header
        self.data = data
        self.isOpened = isOpened
    }
}

import Foundation
class TopicMapViewModel{

    var subjectID: UUID
    let sectionTitles = ["topics", "maps"]

    var topics = [TopicViewModel]()
    var maps = [MapViewModel]()
    var sections = [Sections]()
    
    
    var numberOfTopics:Int{
        topics.count
    }
    var numberOfMaps:Int{
        maps.count
    }
    init(subjectID: UUID,sectionsCount: Int) {
        self.subjectID = subjectID
        getAllTopics()
        getAllMaps()
        self.sections = [Sections(header: "topics", data: .topics(topics)), Sections(header: "maps", data: .maps(maps))]

    }
    
    func toggleSection(_ section: Int) {
        sections[section].isOpened = !sections[section].isOpened
    }
    
    func isSectionCollapsed(_ section: Int) -> Bool {
        return sections[section].isOpened
    }
    

    func numberOfRowsForTopics() -> Int{
        return numberOfTopics
    }
    func numberOfRowsForMaps()-> Int{
        return numberOfMaps
    }
    
    func numberOfRows(by section: Int)->Int{
        if section == 0{
            return sections[section].isOpened ?
            numberOfRowsForTopics() : 0
        }else{
            return sections[section].isOpened ?
            numberOfRowsForMaps() : 0
        }
    }
    
    func topic(by index:Int) ->TopicViewModel{
        topics[index]
    }
    
    func map(by index:Int) ->MapViewModel{
         maps[index]
    }
    
    
    //MARK: Create
    func insertTopic(title: String, id: UUID){
        CoreDataManager.shared.addTopicToSubject(title:title,subjectID: subjectID)
    }
    
    //MARK: Read
    func getAllMaps(){
        maps = CoreDataManager.shared.getAllMapsForSubject(subjectid: subjectID).map(MapViewModel.init)
    }
    
    
    func getAllTopics(){
        topics = CoreDataManager.shared.getAllTopicsForSubject(subjectid: subjectID).map(TopicViewModel.init)
        //print(topics.count)
    }
    
    //MARK: delete
    
    func deleteTopic(topic:TopicViewModel){
        CoreDataManager.shared.deleteTopic(topicID: topic.id)
        getAllTopics()
        print("delete Topic called \(topics.count)")
    }
    //func deleteTopic(subject)
    
    func deleteMap(map: MapViewModel){
        CoreDataManager.shared.deleteMap(mapID:map.id)
        getAllMaps()
        print("delete map called \(maps.count)")
    }
}
