//
//  TopicMapViewControllerUpdatingTopicsMapsManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/2/24.
//

import Foundation

enum SectionType: Int {
    case topics = 0
    case maps = 1
}

extension TopicMapViewModel {
    func sectionType(for section: Int) -> SectionType {
        return topicMapPrecedence == 0 ? SectionType(rawValue: section)! : SectionType(rawValue: 1 - section)!
    }
}
extension TopicMapViewController{
    func updateSection(type: SectionType) {
        print("update \(type) called")
        
        switch type {
        case .topics:
            viewmodel.getAllTopics()
        case .maps:
            viewmodel.getAllMaps()
        }
        
        let wasEmpty = type == .topics ? viewmodel.numberOfTopics == 1 : viewmodel.numberOfMaps == 1
        let otherIsEmpty = type == .topics ? viewmodel.numberOfMaps == 0 : viewmodel.numberOfTopics == 0
        
        if wasEmpty && otherIsEmpty {
            handleFirstInsertion(for: type)
        } else {
            handleSubsequentInsertion(for: type, wasEmpty: wasEmpty)
        }
    }
    
    private func handleFirstInsertion(for type: SectionType) {
        viewmodel.setOpenedFirst(subjectID: viewmodel.subjectID, openedFirst: Int16(type.rawValue))
        let newSection = Sections(header: type == .topics ? "topics" : "maps",
                                  data: type == .topics ? .topics(viewmodel.topics) : .maps(viewmodel.maps))
        viewmodel.sections.append(newSection)
        
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.insertSections(IndexSet(integer: 0))
            })
        }
        print("first")
    }
    
    private func handleSubsequentInsertion(for type: SectionType, wasEmpty: Bool) {
        print("handle subsequent insertion")
        let sectionIndex = viewmodel.topicMapPrecedence == type.rawValue ? 0 : 1
        let itemIndex = type == .topics ? viewmodel.numberOfTopics - 1 : viewmodel.numberOfMaps - 1
        let indexPath = IndexPath(row: itemIndex, section: sectionIndex)
        
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates( {
                if wasEmpty && self.viewmodel.topicMapPrecedence != type.rawValue {
                    let newSection = Sections(header: type == .topics ? "topics" : "maps",
                                              data: type == .topics ? .topics(self.viewmodel.topics) : .maps(self.viewmodel.maps))
                    
                    self.viewmodel.sections.append(newSection)
                    print("new section header: \(newSection.header)")
                    print("sections count: \(self.viewmodel.sections.count)")
                    print("header titles:")
                    for section in self.viewmodel.sections{
                        print(section.header)
                        
                    }
                    self.collectionView.insertSections(IndexSet(integer: indexPath.section))
                } else {
                    self.collectionView.insertItems(at: [indexPath])
                }
            },completion: {finished in
                if finished{
                    DispatchQueue.main.async{
                        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)

                        
                    }
                }
                
            })
        }
        print(sectionIndex == 0 ? "second" : "third")
    }
}
