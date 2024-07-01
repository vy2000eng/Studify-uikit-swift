//
//  SubjectListViewControllerDelagate.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/3/24.
//

import Foundation
import UIKit
import SwipeCellKit

extension SubjectListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TopicMapViewController(subjectID: viewModel.subject(by: indexPath.row).id,subjectTitle: viewModel.subject(by: indexPath.row).name)
        navigationController?.pushViewController(vc, animated:true)
    }
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func deleteSubject(at indexPath: IndexPath ){
        //        let subject = viewModel.subject(by: indexPath.row)
        //        viewModel.deleteSubject(subject: subject)
        let alert = UIAlertController(
            title: "Are you sure you want to delete subject?",
            message: "This action cannot be undone",
            preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "cancel",
                style: .default,
                handler: {[weak self] UIAlertAction in
                    self?.dismiss(animated: true)
                }
            ))
        alert.addAction(
            UIAlertAction(
                title: "delete subject",
                style: .destructive,
                handler: {[weak self] UIAlertAction in
                    
                    guard let subject = self?.viewModel.subject(by: indexPath.row)else{
                        fatalError("Couldn't delete subject")
                        
                    }
                    self?.viewModel.deleteSubject(subject: subject)
                    DispatchQueue.main.async {
                        self?.collectionView.deleteItems(at: [indexPath])
                    }
                }
                
            ))
        
        present(alert, animated: true)
    }
    
}
    
    

extension SubjectListViewController:SwipeCollectionViewCellDelegate{
 
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .left else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                
            self.deleteSubject(at: indexPath)
                
          
        }
        deleteAction.image = UIImage(named: "delete_icon")
        return [deleteAction]
    }
    
    
}
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
//            self?.deleteTask(at: indexPath)
//            completionHandler(true)
//        }
//        let configuration = UISwipeActionsConfiguration(actions: [action])
//        configuration.performsFirstActionWithFullSwipe = true
//        return configuration
//    }
//    
//    func deleteTask(at indexPath: IndexPath ){
//        let subject = viewModel.subject(by: indexPath.row)
//        viewModel.deleteSubject(subject: subject)
//        tableView.deleteRows(at: [indexPath], with: .fade)
//    }
//    
//    
//    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let vc = TopicMapViewController(subjectID: viewModel.subject(by: indexPath.row).id,subjectTitle: viewModel.subject(by: indexPath.row).name)
//        navigationController?.pushViewController(vc, animated:true)
//    }
//}
