//
//  FlashCardListViewControllerDataSource.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/25/24.
//

import Foundation

import UIKit

extension FlashCardListViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return viewmodel.numberOfListSetFlashCards
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? FlashCardListCollectionViewCell else{
            return UICollectionViewCell()
        }
        let flashcard = viewmodel.flashcard(by: indexPath.row)
        cell.configure(flashCard: flashcard)
        cell.delegate = self
        
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
