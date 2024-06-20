//
//  DetailsViewDelegate.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import Foundation
import UIKit

extension TopicMapViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as? SubjectTopicViewCell
            else{
                return UICollectionViewCell()
            }
            let topic = viewmodel.topic(by: indexPath.row)
            cell.configure(with: topic)
            cell.delegate = self
            return cell
            
        }else{
            guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as? SubjectMapViewCell
            else{
                return UICollectionViewCell()
            }
            let map = viewmodel.map(by: indexPath.row)
            cell.configure(with: map)
            cell.delegate = self
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind:     kind, withReuseIdentifier: "headerCell", for: indexPath) as? TopicMapHeaderViewCell
        else{
            let fallbackView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "fallbackIdentifier", for: indexPath)
            return fallbackView
        }
        cell.configureTopicHeader(title: viewmodel.sections[indexPath.section].header)
        let imageName = viewmodel.sections[indexPath.section].isOpened ? "arrow.left.arrow.right" : "arrow.up.arrow.down"
        cell.collapseButton.setImage(UIImage(systemName: imageName), for: .normal)
        cell.collapseButton.addTarget(self, action: #selector(handleCollapseButton(_:)), for: .touchUpInside)
        cell.collapseButton.tag = indexPath.section
        cell.addButton.isHidden = viewmodel.isSectionCollapsed(indexPath.section) ? false : true
        cell.addButton.addTarget(self, action: #selector(handleAddButton(_:)), for: .touchUpInside)
        cell.addButton.tag = indexPath.section
        
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // The logic for determining the number of rows is inside of the 'viewmodel.numberOfRows' method
        return viewmodel.numberOfRows(by: section)
    }
}

// objc methods
extension TopicMapViewController{
    /*MARK: handlecollapseButton
     How this works?
     1.) 
     There is a Sections class in TopicMapViewModel
     Inside of that sections class there is a boolean property called isOpened
     So, we toggle that property, and then we reload the sections
     2.)
     When the section is toggled and then reloaded this is called:
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
            MARK: determines the rows based the value of isOpened, i.e isOpened == false ? 0 : numberOfRowsFor...()
            return viewmodel.numberOfRows(by: section)
     */
    
    @objc
    func handleCollapseButton(_ sender:UIButton){
        let section = sender.tag
        viewmodel.toggleSection(section)
        let indexSet = IndexSet(integer: section)
        collectionView.reloadSections(indexSet)
    }
    /*MARK: handleAddButton
     There are seperate viewcontrollers for adding topics and adding maps.
     Those viewcontrollers are AddNewTopicViewController and AddNewMapViewController respectively.
     Both of those viewcontrols have protocols for delegating addition of a topic or map, implemented by the TopicMapViewController.
     That is the reason for 'vc.delegate = self'
     */
    @objc 
    func handleAddButton(_ sender: UIButton) {
        let section = sender.tag
        if section == 0{
            let vc = AddNewTopicViewController(subjectID: viewmodel.subjectID)
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = AddNewMapViewController(subjectID: viewmodel.subjectID)
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



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
