//
//  SubjectDetailsViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/5/24.
//
enum sectionData{
    case topics([TopicViewModel])
    //case maps([MapViewModel])
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
    var topics = [TopicViewModel]()
    var sections = [Sections]()
    // MARK:  Tested -TMVM init
    init() {
        getAllTopics()
        if numberOfTopics == 0{
            self.sections = []
        }else{
            let topicSection =  Sections(header: "topics", data: .topics(topics))
            self.sections = [topicSection]
            
        }
    }
    
    var background:UIColor{
        ColorManager.shared.currentTheme.colors.backGroundColor
    }
    
    var fontColor:UIColor{
        ColorManager.shared.currentTheme.colors.fontColor
    }
    
    var titleFont:UIFont{
        ColorManager.shared.currentTheme.colors.primaryFont
    }
    
    var subtitleFont:UIFont{
        ColorManager.shared.currentTheme.colors.secondaryFont
    }
    
    //MARK: Tested -TMVM numberOfTopics
    var numberOfTopics:Int{
        topics.count
    }
    
    //MARK: Tested -TMVM sectionsCount
    var sectionsCount:Int{
        return  (numberOfTopics > 0 ? 1 : 0)
    }
    
    //MARK: Tested -TMVM toggleSection
    func toggleSection(_ section: Int) {
        sections[section].isOpened = !sections[section].isOpened
    }
    
    //MARK: Tested -TMVM isSectionCollapsed
    func isSectionCollapsed(_ section: Int) -> Bool {
        return sections[section].isOpened
    }
    
    //MARK: Tested -TMVM numberOfRows
    func numberOfRows(by section: Int)throws ->Int {
        guard section == 0 else {
            throw NSError(domain: "InvalidSectionError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid section index"])
        }
        
        guard let firstSection = sections.first else {
            throw NSError(domain: "EmptySectionsError", code: 2, userInfo: [NSLocalizedDescriptionKey: "No sections available"])
        }
    
        return firstSection.isOpened ? numberOfTopics : 0
    }
    
    //MARK: Tested -TMVM topic
    func topic(by index:Int) ->TopicViewModel{
        return topics[index]
    }
    
    //MARK: Tested -TMVM -getAllTopics
    func getAllTopics(){
        topics = CoreDataManager.shared.getAllTopics().map(TopicViewModel.init)
    }
    
    //MARK: Tested -TMVM deleteTopic
    func deleteTopic(topic:TopicViewModel){
        CoreDataManager.shared.deleteTopic(topicID: topic.id)
        getAllTopics()
    }
    
}

