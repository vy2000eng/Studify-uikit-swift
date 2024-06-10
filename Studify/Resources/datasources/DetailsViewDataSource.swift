//
//  DetailsViewDelegate.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import Foundation
import UIKit



//extension TopicMapViewController: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//    }
    
    
    
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
