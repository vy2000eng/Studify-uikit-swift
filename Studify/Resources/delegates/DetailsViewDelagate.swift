//
//  DetailsViewDataSource.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import Foundation
import UIKit



extension TopicMapViewController: UICollectionViewDelegate{
    
    func deleteTopic(at indexPath: IndexPath){
        let topic = viewmodel.topic(by: indexPath.row)
        viewmodel.deleteTopic(topic: topic)
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([topic])
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    func deleteMap(at indexPath: IndexPath){
        let map = viewmodel.map(by: indexPath.row)
        viewmodel.deleteMap(map:map)
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([map])
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let vc = FlashCardSetViewController(topicID: viewmodel.topic(by: indexPath.row).id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
