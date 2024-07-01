//
//  FlashCardSetViewControllerDataSource.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/22/24.
//

import Foundation


import UIKit

extension FlashCardSetViewController: UICollectionViewDataSource{
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewmodel.numberOfFlashCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

     
        
        if indexPath.section == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "setCell", for: indexPath) as? FlashCardSetCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            let flashcard = viewmodel.flashcard(by: indexPath.row)
            cell.configure(flashcard: flashcard, bottomTopStyle: 0)
            return cell
            
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallSetCell", for: indexPath) as? FlashCardSetCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            
            let flashcard = viewmodel.flashcard(by: indexPath.row)
            cell.configure(flashcard: flashcard,bottomTopStyle: 1)
            if indexPath.row == viewmodel.currentIndex{
                print("should be called here")
                cell.mainView.backgroundColor = warmTreeTones.lightPrimary
            }
            return cell
            
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
}
