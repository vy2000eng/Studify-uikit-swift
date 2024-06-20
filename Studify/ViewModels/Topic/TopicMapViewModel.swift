//
//  SubjectDetailsViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/5/24.
//

let sectionTitles = ["topics", "maps"]

enum sectionData{
    case topics([TopicViewModel])
    case maps([MapViewModel])
}

class Sections{
    let header: String
    let data: sectionData
    var isOpened: Bool = false
    
    init(header: String, data: sectionData, isOpened: Bool = false ) {
        self.header = header
        self.data = data
        self.isOpened = isOpened
    }
}

import Foundation
class TopicMapViewModel{

    var subjectID: UUID
   // var collapsedSections: [Bool]
    let sectionTitles = ["topics", "maps"]

    var topics = [TopicViewModel]()
    var maps = [MapViewModel]()
    var sections = [Sections]()
    //var isRowSectionCollapsed = false
    
    
    var numberOfTopics:Int{
        topics.count
    }
    var numberOfMaps:Int{
        maps.count
    }
    init(subjectID: UUID,sectionsCount: Int) {
        self.subjectID = subjectID
      //  self.collapsedSections = Array(repeating: false, count: sectionsCount)
        getAllTopics()
        getAllMaps()
        self.sections = [Sections(header: "topics", data: .topics(topics)), Sections(header: "maps", data: .maps(maps))]

    }
    
    func toggleSection(_ section: Int) {
     ///  collapsedSections = collapsedSections.first(where: {$0 == [section]})
        //var s = isSectionCollapsed(section)
        sections[section].isOpened = !sections[section].isOpened


        //collapsedSections[section] = collapsedSections[section] ? false : true
    }
    
    func isSectionCollapsed(_ section: Int) -> Bool {
        return sections[section].isOpened
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
            return sections[section].isOpened ?
            0 : numberOfRowsForTopics()
        }else{
            return sections[section].isOpened ?
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
            // print(maps.count)
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
    
    func deleteMap(map: MapViewModel){
        CoreDataManager.shared.deleteMap(mapID:map.id)
        getAllMaps()
        print("delete map called \(maps.count)")
    }
}
