//
//  FlashCardGameViewControllerDataSource.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/21/24.
//

import Foundation
import UIKit

extension FlashCardGameViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewmodel.numberOfFlashCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "setCell", for: indexPath) as? FlashCardGameCollectionViewCell else{
            return UICollectionViewCell()
        }
        let flashcard = viewmodel.flashcard(by: indexPath.row)
        cell.configure(flashcard: flashcard)
        //cell.configure(flashCard: flashcard,bottomTopStyle: 0)
        cell.delegate = self
        
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
}
