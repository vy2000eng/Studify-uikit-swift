//
//  DetailsViewDelegate.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import Foundation
import UIKit

//
//


class sections{
    let header: TopicMapHeaderViewCell
    let topicData: SubjectTopicViewCell
    let mapData: SubjectMapViewCell
    
    init(header: TopicMapHeaderViewCell, topicData: SubjectTopicViewCell, mapData: SubjectMapViewCell) {
        self.header = header
        self.topicData = topicData
        self.mapData = mapData
    }
    
}


//    let topicData: TopicViewModel
//    let mapData: MapViewModel
//    
//    init(header: String, topicData: TopicViewModel) {
//        self.header = header
//        self.topicData = topicData
//        //self.mapData = mapData
//    }
//    
//    init(header: String, mapData: MapViewModel){
//        self.header = header
//        self.mapData = mapData
//        
//    }
//}
extension TopicMapViewController: UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as? SubjectTopicViewCell
            else{
                return UICollectionViewCell()
            }
            let topic = viewmodel.topic(by: indexPath.row)
            cell.configure(with: topic)
            return cell
            
        }else{
            guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as? SubjectMapViewCell
            else{
                return UICollectionViewCell()
            }
            let map = viewmodel.map(by: indexPath.row)
            cell.configure(with: map)
            return cell
            //return collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath)
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind:     kind, withReuseIdentifier: "headerCell", for: indexPath) as? TopicMapHeaderViewCell
        else{
            //return supple
            
            let fallbackView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "fallbackIdentifier", for: indexPath)
            // Configure fallbackView or log an error if necessary
            return fallbackView
        }
        cell.configureTopicHeader(title: viewmodel.sections[indexPath.section].header)
        let imageName = viewmodel.sections[indexPath.section].isOpened ? "arrow.left.arrow.right" : "arrow.up.arrow.down"
        cell.collapseButton.setImage(UIImage(systemName: imageName), for: .normal)
        cell.collapseButton.addTarget(self, action: #selector(handleCollapseButton(_:)), for: .touchUpInside)
        cell.collapseButton.tag = indexPath.section

        
        
        
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewmodel.numberOfRows(by: section)
        //        if section == 0{
        //            return viewmodel.numberOfTopics
        //        }else{
        //            return viewmodel.numberOfMaps
        //        }
    }
}
extension TopicMapViewController{
    @objc
    func handleCollapseButton(_ sender:UIButton){
       let section = sender.tag
        viewmodel.toggleSection(section)
        let indexSet = IndexSet(integer: section)

        collectionView.reloadSections(indexSet)

        
        
        
        
    }
    
}

    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.section == 0{
//            
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0{
//           return viewmodel.numberOfRowsForTopics()
//
//        }else{
//            return viewmodel.numberOfRowsForMaps()
//
//        }
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//    }
//}
//    
//    
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       // viewModel.
//       // let section = sections[section]
//           //return section.isExpanded ? section.items.count : 0
//        return viewmodel.numberOfRows(by: section)
//
//    }
//    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0{
//            
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? SubjectTopicViewCell
//            else{
//                return UITableViewCell()
//            }
//            let subject = viewmodel.topic(by: indexPath.row)
//            cell.configure(with: subject)
//            //let taskSummary = viewModel.getTasksByType()
//            //cell.configure(completed: taskSummary.complete.description, incompleted: taskSummary.incomplete.description)
//            return cell
//        }else{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for:indexPath) as? SubjectMapViewCell
//            else{
//                return UITableViewCell()
//            }
//            let map = viewmodel.map(by: indexPath.row)
//            cell.configure(with: map)
//            
//            return cell
//        }
//        
//    }
//
////    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            let headerView = TopicMapHeaderViewCell()
//            headerView.addButton.addTarget(self, action: #selector(handleAddButton(_:)), for: .touchUpInside)
//            headerView.addButton.tag = section
//            headerView.sectionTitle.text = sectionTitles[section]
//            headerView.collapseButton.addTarget(self, action: #selector(handleCollapseButton(_:)), for: .touchUpInside)
//            headerView.collapseButton.tag = section
//            return headerView
//    }
//    
//    
//
//    @objc func handleAddButton(_ sender: UIButton) {
//        let section = sender.tag
//        if section == 0{
//            let vc = AddNewTopicViewController(subjectID: viewmodel.subjectID)
//            navigationController?.pushViewController(vc, animated: true)
//        }else{
//            let vc = AddNewMapViewController(subjectID: viewmodel.subjectID)
//            navigationController?.pushViewController(vc, animated: true)
//
//        }
//    }
//    
//    @objc func handleCollapseButton(_ sender:UIButton){
//        let section = sender.tag
//        viewmodel.toggleSection(section)
//        tableView.beginUpdates()
//        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
//        tableView.endUpdates()
//        tableView.layoutIfNeeded()  // Forces the table view to immediately layout its subviews
//
//    }
//}
