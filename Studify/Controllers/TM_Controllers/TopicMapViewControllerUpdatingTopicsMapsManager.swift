//
//  TopicMapViewControllerUpdatingTopicsMapsManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/2/24.
//

import Foundation

enum SectionType: Int {
    case topics = 0
    //case maps = 1
}

extension TopicViewModel {
//    func sectionType(for section: Int) -> SectionType {
//        return topicMapPrecedence == 0 ? SectionType(rawValue: section)! : SectionType(rawValue: 1 - section)!
//    }

}
extension TopicViewController{
    func updateSection(type: SectionType) {
        print("update \(type) called")
        
        switch type {
        case .topics:
            viewmodel.getAllTopics()
        }
        
        viewmodel.numberOfTopics > 1
        ? handleSubsequentInsertion(for: .topics)
        :handleFirstInsertion(for: .topics)
    
    }
    
    private func handleFirstInsertion(for type: SectionType) {
        let newSection = Sections(header: "Topics" ,
                                  data: .topics(viewmodel.topics) )
        viewmodel.sections.append(newSection)
        assert(viewmodel.topics.count != 0)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else{return}
            
      
            
            self.collectionView.performBatchUpdates({[weak self] in
                guard let self = self else{return}
                self.collectionView.insertSections(IndexSet(integer: 0))
            })
        }
        print("first")
    }
    
    private func handleSubsequentInsertion(for type: SectionType) {
        NSLog("handle subsuquent insertion")
       // let sectionIndex = 0
        let itemIndex =  viewmodel.numberOfTopics - 1
        let indexPath = IndexPath(row: itemIndex, section: 0)
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates( {

                    self.collectionView.insertItems(at: [indexPath])
            },completion: {finished in
                if finished{
                    DispatchQueue.main.async{
                        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)

                        self.navigationItem.rightBarButtonItem = self.createOptionsBarButtonItem()

                    }
                }
            })
        }
      //  print("sections Count: \(viewmodel.sections.count)")
       // print(sectionIndex == 0 ? "second" : "third")

    }
}

extension TopicViewController{
    func testupdateSection(type: SectionType){
        updateSection(type: type)
    }
    func testHandleFirstInsertion(type:SectionType){
        handleFirstInsertion(for: type)
        
    }
    
    func testHandleSubsequentInsertion(type:SectionType){
        handleSubsequentInsertion(for: type)
        
    }
}
