//
//  DetailsViewDelegate.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import Foundation
import UIKit

extension TopicMapViewController: UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // viewModel.
       // let section = sections[section]
           //return section.isExpanded ? section.items.count : 0
        return viewmodel.numberOfRows(by: section)
//        if viewmodel.isSectionCollapsed(section){
//            return 0
//        }
//        return viewmodel.numberOfRows(by: section)
        //return viewModel.numberOfRow
        //return 0
//        if viewmodel.isSectionCollapsed(section){
//            return 0
//        }else{
//            return viewmodel.numberOfRows(by: section)
//
//            
//        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? SubjectTopicViewCell
            else{
                return UITableViewCell()
            }
            let subject = viewmodel.topic(by: indexPath.row)
            cell.configure(with: subject)
            //let taskSummary = viewModel.getTasksByType()
            //cell.configure(completed: taskSummary.complete.description, incompleted: taskSummary.incomplete.description)
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for:indexPath) as? SubjectMapViewCell
            else{
                return UITableViewCell()
            }
            let map = viewmodel.map(by: indexPath.row)
            cell.configure(with: map)
            
            return cell
        }
        
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        sectionTitles[section]
//    }
//    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    

    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
            
            let headerView = TopicMapHeaderViewCell()
            headerView.addButton.addTarget(self, action: #selector(handleAddButton(_:)), for: .touchUpInside)
            headerView.addButton.tag = section
            headerView.sectionTitle.text = sectionTitles[section]
            headerView.collapseButton.addTarget(self, action: #selector(handleCollapseButton(_:)), for: .touchUpInside)
            headerView.collapseButton.tag = section
            return headerView
//        
//        if viewmodel.isSectionCollapsed(section){
//            return headerView
//
//            
//        }else{
//            return headerView
//
//            
//        }
//            
            
        
    
    
    }
    
    
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.systemBackground  // Customize as needed
//
//        // Label for the title
//        let label = UILabel()
//        label.text = sectionTitles[section]
//        label.translatesAutoresizingMaskIntoConstraints = false
//        headerView.addSubview(label)
//
//        // Button on the right side of the header
//        let button = UIButton(type: .system)
//        let collapseButton = UIButton(type: .system)
//       // let button = UIButton(type: .system)
//        let plusImage = UIImage(systemName: "plus")  // Using system image
//        let collapseImage = UIImage(systemName: "ellipsis")
//        collapseButton.setImage(collapseImage, for: .normal)
//        button.setImage(plusImage, for: .normal)
//        
//       // button.setTitle("Add", for: .normal)  // Customize your button title here
//        button.addTarget(self, action: #selector(handleAddButton(_:)), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tag = section  // Tag button with section index to identify in the action
//        
//        collapseButton.addTarget(self, action: #selector(handleCollapseButton(_:)), for: .touchUpInside)
//        collapseButton.translatesAutoresizingMaskIntoConstraints = false
//        collapseButton.tag = section
//        
//        headerView.addSubview(button)
//        headerView.addSubview(collapseButton)
//
//        // Constraints for the label
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
//            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
//        ])
//
//        // Constraints for the button
//        NSLayoutConstraint.activate([
//            collapseButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
//            collapseButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//            button.trailingAnchor.constraint(equalTo: collapseButton.leadingAnchor,constant: -20),
//            button.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
//        ])
//
//        return headerView
//    }

    @objc func handleAddButton(_ sender: UIButton) {
        let section = sender.tag
        if section == 0{
            let vc = AddNewTopicViewController(subjectID: viewmodel.subjectID)
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = AddNewMapViewController(subjectID: viewmodel.subjectID)
            navigationController?.pushViewController(vc, animated: true)

        }
    }
    
    @objc func handleCollapseButton(_ sender:UIButton){
        let section = sender.tag
        viewmodel.toggleSection(section)
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        tableView.endUpdates()
        tableView.layoutIfNeeded()  // Forces the table view to immediately layout its subviews

        
        
//        // tableView.beginUpdates()
//        let indexPaths = (0..<viewmodel.numberOfRows(by: section)).map { IndexPath(row: $0, section: section) }
//        print(indexPaths)
//        tableView.beginUpdates()
//        tableView.reloadRows(at: indexPaths, with: .automatic)
//        tableView.endUpdates()
        //tableView.reloadRows(at: indexPaths, with: .fade)
    }


        //tableView.reloadSections(IndexSet(integer: section), with: .fade)
       // tableView.endUpdates()

       // let numberOfRows = viewmodel.numberOfRows(by: section)

        
        
//
//         // Get the count of rows for the given section
//         let numberOfRows = viewmodel.numberOfRows(by: section)
//         
//         // Create index paths from 0 up to but not including 'numberOfRows'
//         let indexPaths = (0..<numberOfRows).map { IndexPath(row: $0, section: section) }
//
//         // Debug prints to verify the correct index paths are generated
//         print("Number of rows: \(numberOfRows)")
//         print("Index paths: \(indexPaths)")
//
//         // Use these index paths to reload rows
////         if viewmodel.isSectionCollapsed(section) {
////             tableView.reloadSections(IndexSet(integer: section), with: .fade)
////         } else {
////             tableView.reloadSections(IndexSet(integer: section), with: .automatic)
////         }
        
//        let section = sender.tag
//          viewmodel.toggleSection(section)
//        let range = viewmodel.numberOfRows(by: section)
//        if viewmodel.isSectionCollapsed(section){
//            let indexPaths = (0..<range).map { IndexPath(row: $0, section: section) }
//            tableView.reloadRows(at: indexPaths, with: .fade)
//
//            
//            print(indexPaths)
//
//            
//        }else{
//            let indexPaths = (0..<range).map { IndexPath(row: $0, section: section) }
//            print(indexPaths)
//            
//           // let indexPaths = (0..<1).map { IndexPath(row: $0, section: section) }
//           // print(indexPaths)
//            
//        }
   

        
//            tableView.reloadRows(at: indexPaths, with: .fade)
//          } else {
//              tableView.reloadRows(at: indexPaths, with: .fade)
//
//              //tableView.reloadSections(indexPaths, with: .fade)
//          }

        //UIView.animate(withDuration: 0.3) {
            
            //let indexSet = IndexSet(integer: section)
            
//            if self.viewmodel.isSectionCollapsed(section) {
//                self.tableView.reloadSections(indexSet, with: .fade)
//            } else {
//                self.tableView.reloadSections(indexSet, with: .fade)
//            }
       // }

//          UIView.animate(withDuration: 0.3) {
//              if self.viewmodel.isSectionCollapsed(section) {
//                  // If it's collapsed, reload sections might suffice without specifying rows
//                  //self.tableView.reloadRows(at:IndexSet(integer: section), with: .fade)
//                  self.tableView.reloadData()
//              } else {
//                  // Expand: Reload sections to update the count and content of rows
//                  self.tableView.reloadData()
//
//                //  self.tableView.reloadSections(IndexSet(integer: section), with: .fade)
//              }
//          }
        
        
        
        
//        let section = sender.tag
//        print(section)
//         viewmodel.toggleSection(section)
//
//         let indexSet = IndexSet(integer: section)
//         if viewmodel.isSectionCollapsed(section) {
//             // Reload the entire section if it's collapsed
//             //let rowCount = viewmodel.numberOfRows(by: section)  // Assuming you have a method to get row counts
//             //let indexPaths = (0..<rowCount).map { IndexPath(row: $0, section: section) }
//             
//             //tableView.reloadRows(at: indexPaths, with: .fade)
//             tableView.reloadSections(indexSet, with: .fade)
//
//
//             //tableView.del
//            
//             // tableView.reloadData()
//             //tableView.reloadRows(at: , with: .fade)
//
//            // tableView.reloadSections(i, with: .fade)
//         } else {
//             // Or just reload the rows if you're expanding
//             let rowCount = viewmodel.numberOfRows(by: section)  // Assuming you have a method to get row counts
//             let indexPaths = (0..<rowCount).map { IndexPath(row: $0, section: section) }
//             tableView.reloadRows(at: indexPaths, with: .fade)
//         }
//        let section = sender.tag
//       // inde
//        if section == 0 {
//            print(section)
//            viewmodel.isRowSectionCollapsed.toggle()
//            tableView.reloadRows(at: [IndexPath.SubSequence(row: 0, section: section)], with: .automatic)
//            
//            //tableView.reloadRows(at: [IndexPath], with: )
//
//            //tableView.reloadRows(at: [indexPath], with: .automatic)
//
//        }else{
//            print(section)
//            
//        }
  //  }
    
}
