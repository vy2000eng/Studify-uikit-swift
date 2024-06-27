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
            var flashcard = viewmodel.flashcard(by: indexPath.row)
            //var flashcardString = viewmodel.flashcardDisplayMode(by: indexPath.row, isShowingFront: flashcard.isShowingFront)
          //  let flashcard = viewmodel.flashcard(by: indexPath.row)
          //  let flashcardString = viewmodel.flashcardDisplayMode(by: indexPath.row, isShowingFront: flashcard.isShowingFront)
           // cell.configure(flashCardString: flashcardString, bottomTopStyle: 0)
             cell.configure(flashcard: flashcard, bottomTopStyle: 0)
            return cell
            
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallSetCell", for: indexPath) as? FlashCardSetCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            var flashcard = viewmodel.flashcard(by: indexPath.row)
            //var flashcardString = viewmodel.flashcardDisplayMode(by: indexPath.row, isShowingFront: flashcard.isShowingFront)
           // let flashcard = viewmodel.flashcard(by: indexPath.row)
            cell.configure(flashcard: flashcard,bottomTopStyle: 1)
            //cell.configure(flashCardString: flashcardString, bottomTopStyle: 1)
            return cell
            
        }
     
        
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // The logic for determining the number of rows is inside of the 'viewmodel.numberOfRows' method
//        return viewmodel.numberOfRows(by: section)
//    }
    
}
