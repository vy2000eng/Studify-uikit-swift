//
//  FlashCardGameViewControllerDataSource.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/21/24.
//

import Foundation
import UIKit

//extension FlashCardGameViewController: UIPageViewControllerDataSource{
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        
//    }
//}

//extension FlashCardGameViewController:UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("this is called")
//        return flashcardGameViewModel.numberOfGameFlashCards
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "setCell", for: indexPath) as? FlashCardGameCollectionViewCell else{
//            return UICollectionViewCell()
//        }
//        
//        let flashcard = flashcardGameViewModel.flashcard(by: indexPath.row)
//      //  flashcardGameViewModel.currentIndex += 1
//      //  flashcardGameViewModel.gameFlashCards.remove(at: 0)
//        cell.configure(flashcard: flashcard)
//        //cell.configure(flashCard: flashcard,bottomTopStyle: 0)
//        //cell.delegate = self
//        
//        
//        return cell
//    }
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        1
//    }
//    
//    
//}
