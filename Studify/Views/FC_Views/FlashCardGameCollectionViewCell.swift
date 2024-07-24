//
//  FlashCardGameCollectionViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/21/24.
//

import Foundation
import SwipeCellKit
import UIKit
class FlashCardGameCollectionViewCell:SwipeCollectionViewCell{
    let flashcardSetCollectionViewCell:FlashCardSetCollectionViewCell
    
    
    
    override init(frame: CGRect) {
        self.flashcardSetCollectionViewCell = FlashCardSetCollectionViewCell()
        super.init(frame: frame)
        setup()

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}
extension FlashCardGameCollectionViewCell{
    
    func setup(){
        flashcardSetCollectionViewCell.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(flashcardSetCollectionViewCell)
        setupConstraints()
        
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            flashcardSetCollectionViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            flashcardSetCollectionViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flashcardSetCollectionViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            flashcardSetCollectionViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
        
    }
    
    func configure(flashcard: FlashcardViewModel){
        flashcardSetCollectionViewCell.configure(flashcard: flashcard, bottomTopStyle: 0)
    }
    
}
