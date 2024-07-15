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
        
        if section == 0{
            return viewmodel.numberOfFlashCards
        }else{
            if viewmodel.smallSetSection.isOpened{
                return viewmodel.numberOfFlashCards
            }
            else{
                return 0
            }
        }
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
                cell.mainView.backgroundColor = ColorManager.shared.currentTheme.colors.bottomColor
             //   cell.mainView.backgroundColor = ColorManager.shared.currentTheme.colors.listColor
            }
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind:     kind, withReuseIdentifier: "headerCell", for: indexPath) as! FlashcardSmallSetViewControllerHeader
            let imageName = viewmodel.smallSetSection.isOpened ? "chevron.down" : "chevron.up"
            cell.collapseButton.setImage(UIImage(systemName: imageName), for: .normal)
            cell.collapseButton.addTarget(self, action: #selector(handleCollapseButton(_:)), for: .touchUpInside)
          
           
            return cell
        }
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewmodel.sectionsCount
//        if viewmodel.numberOfFlashCards > 0{
//            return 2
//        }else{
//            return 1
//        }
    }
    
}

extension FlashCardSetViewController{
    @objc
    func handleCollapseButton(_ sender:UIButton){
        viewmodel.toggleSection()
        DispatchQueue.main.async{
            
            self.collectionView.performBatchUpdates({
                
                self.collectionView.reloadSections(IndexSet(integer: 1))
                if self.viewmodel.isSectionCollapsed(){
                   
                    self.collectionView.reloadItems(at: [IndexPath(row: self.viewmodel.currentIndex, section: 1)])
                }
            },completion: { finished in
                if finished {
                    
                    DispatchQueue.main.async{
                       
                        if self.viewmodel.isSectionCollapsed(){
                            self.collectionView.scrollToItem(at: IndexPath(row: self.viewmodel.currentIndex, section: 1), at: .centeredHorizontally, animated: true)
                        }
                    }
                }
            })
        }
    }
}
