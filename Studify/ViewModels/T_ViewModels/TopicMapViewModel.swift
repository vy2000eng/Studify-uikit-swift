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
import UIKit
class TopicMapViewModel{
    
    var subjectID: UUID
    var topics = [TopicViewModel]()
    var maps = [MapViewModel]()
    var sections = [Sections]()
    var topicMapPrecedence:Int16 = -1

    init(subjectID: UUID) {
        
        self.subjectID = subjectID
        getAllTopics()
        getAllMaps()
        
        let topicSection =  Sections(header: "topics", data: .topics(topics))
        let mapSection = Sections(header: "maps", data: .maps(maps))
        
        if !bothSectionEmpty{
            topicMapPrecedence = getOpenedFirst(subjectID: subjectID)
      
        }
        else{
            setOpenedFirst(subjectID: subjectID, openedFirst: -1)
        }
        
        switch(topicMapPrecedence){
            
        case 0:
           
            self.sections = mapsIsEmpty ? [topicSection] : [topicSection,mapSection]
            break
        case 1:
            
            self.sections = topicsIsEmpty ?   [mapSection] : [mapSection, topicSection]
            break
        default:
            
            self.sections = []
            break
        }
    }
    
    var background:UIColor{
        ColorManager.shared.currentTheme.colors.backGroundColor
    }
    
    var bothSectionEmpty:Bool{
        return (numberOfTopics == 0 && numberOfMaps == 0) ? true: false
    }
    
    var mapsIsEmpty: Bool{
        return numberOfMaps == 0
    }
    
    var topicsIsEmpty:Bool{
        return numberOfTopics == 0
    }
    
    var numberOfTopics:Int{
        topics.count
    }
    var numberOfMaps:Int{
        maps.count
    }
    var sectionsCount:Int{
        return (numberOfMaps > 0 ? 1 : 0) + (numberOfTopics > 0 ? 1 : 0)
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
        if topicMapPrecedence == 0{
            return section == 0 ?
            (sections[section].isOpened ? numberOfRowsForTopics() : 0)  :
            (sections[section].isOpened ? numberOfRowsForMaps()   : 0)
        }
        if topicMapPrecedence == 1 {
            return section == 0 ?
            (sections[section].isOpened ? numberOfRowsForMaps()   : 0)  :
            (sections[section].isOpened ? numberOfRowsForTopics() : 0)
        }
        return 0
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
    
    func setOpenedFirst(subjectID:UUID, openedFirst: Int16 ){
        CoreDataManager.shared.setOpenedFirst(subjectID: subjectID, addedFirst: openedFirst)
        topicMapPrecedence = openedFirst
    }
    
    
    //MARK: Read
    func getAllMaps(){
        maps = CoreDataManager.shared.getAllMapsForSubject(subjectid: subjectID).map(MapViewModel.init)
    }
    
    func getOpenedFirst(subjectID:UUID) ->Int16{
        return CoreDataManager.shared.getOpenedFirst(subjectID: subjectID)
        
    }
    
    
    func getAllTopics(){
        topics = CoreDataManager.shared.getAllTopicsForSubject(subjectid: subjectID).map(TopicViewModel.init)
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

