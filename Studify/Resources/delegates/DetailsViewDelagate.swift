//
//  DetailsViewDataSource.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import Foundation
import UIKit



extension TopicMapViewController: UICollectionViewDelegate{
    
    
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            if indexPath.section == 0{
                self?.deleteTopic(at: indexPath)
                completionHandler(true)
            }else{
                self?.deleteMap(at: indexPath)
                completionHandler(true)
            }
            
            
        }
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    
    
    
    func deleteTopic(at indexPath: IndexPath){
        let topic = viewmodel.topic(by: indexPath.row)
        viewmodel.deleteTopic(topic: topic)
        //tableView.deleteRows(at: [indexPath], with: .fade)
        
        //tableView.deleteRows(at: [IndexPath.SubSequence(row: indexPath.row, section: 0)], with: .fade)
    }
    
    func deleteMap(at indexPath: IndexPath){
        let map = viewmodel.map(by: indexPath.row)
        viewmodel.deleteMap(map:map)
        //tableView.deleteRows(at: [indexPath], with: .fade)
        
        //tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                if indexPath.section == 0{
                    let vc = FlashCardSetViewController(topicID: viewmodel.topic(by: indexPath.row).id)
                    navigationController?.pushViewController(vc, animated: true)
                }
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0{
//            let vc = FlashCardSetViewController(topicID: viewmodel.topic(by: indexPath.row).id)
//            navigationController?.pushViewController(vc, animated: true)
//        }
//        
//    }
    
    
    
}
