//
//  SubjectListViewControllerDelagate.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/3/24.
//

import Foundation
import UIKit

extension SubjectListViewController: UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.deleteTask(at: indexPath)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func deleteTask(at indexPath: IndexPath ){
        let subject = viewModel.subject(by: indexPath.row)
        viewModel.deleteSubject(subject: subject)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TopicMapViewController(subjectID: viewModel.subject(by: indexPath.row).id,subjectTitle: viewModel.subject(by: indexPath.row).name)
        navigationController?.pushViewController(vc, animated:true)
    }
}
