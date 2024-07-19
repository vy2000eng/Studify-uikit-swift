//
//  FlashCardListCollectionViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/25/24.
//

import Foundation
import UIKit
import SwipeCellKit

class FlashCardListCollectionViewCell: SwipeCollectionViewCell {
    lazy var termLabel: UILabel = {
        
        let termLabel = UILabel()
        termLabel.translatesAutoresizingMaskIntoConstraints = false
        termLabel.numberOfLines = 0
        return termLabel
    }()
    
    lazy var defLabel: UILabel = {
        
        let defText = UILabel()
        defText.translatesAutoresizingMaskIntoConstraints = false
        defText.numberOfLines = 0
        return defText
    }()
    
    lazy var topContentView: UIView = {
        
        let topContentView = UIView()
        topContentView.translatesAutoresizingMaskIntoConstraints = false
        topContentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]  // Top left and top right
        return topContentView
    }()
    
    lazy var bottomContentView: UIView = {
        
        let bottomContentView = UIView()
        bottomContentView.translatesAutoresizingMaskIntoConstraints = false
        bottomContentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]   // Top left and top right
        return bottomContentView
    }()
 

    lazy var mainView: UIView = {
        
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.layer.shadowOffset = CGSize(width: 0, height: 1)
        mainView.layer.shadowOpacity = 0.2
        mainView.layer.shadowRadius = 1.0
        mainView.layer.borderWidth = 2
        mainView.layer.cornerRadius = 2
        return mainView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlashCardListCollectionViewCell{
    
    private func setup(){
        contentView.addSubview(mainView)
        mainView.addSubview(topContentView)
        mainView.addSubview(bottomContentView)
        
        topContentView.addSubview(termLabel)
        bottomContentView.addSubview(defLabel)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant:  5),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant:  -5),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            topContentView.topAnchor.constraint(equalTo: mainView.topAnchor),
            topContentView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            topContentView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            bottomContentView.topAnchor.constraint(equalTo: topContentView.bottomAnchor),
            bottomContentView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            bottomContentView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            bottomContentView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            termLabel.topAnchor.constraint(equalTo: topContentView.topAnchor,constant: 10),
            termLabel.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 5),
            termLabel.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor, constant: -5),
            termLabel.bottomAnchor.constraint(equalTo: topContentView.bottomAnchor,constant: -5),
            
            defLabel.topAnchor.constraint(equalTo: bottomContentView.topAnchor,constant: 10),
            defLabel.leadingAnchor.constraint(equalTo: bottomContentView.leadingAnchor,constant:5),
            defLabel.trailingAnchor.constraint(equalTo: bottomContentView.trailingAnchor, constant: -5),
            defLabel.bottomAnchor.constraint(equalTo: bottomContentView.bottomAnchor,constant: -10),
            
        ])
        
    }
    
    func configure(flashCard: FlashcardViewModel){
        
        mainView.layer.borderColor = ColorManager.shared.currentTheme.colors.backGroundColor == .black
        ? UIColor.white.withAlphaComponent(0.1).cgColor
        : UIColor.black.withAlphaComponent(0.1).cgColor
        
        topContentView.backgroundColor = flashCard.topBackgroundColor
        bottomContentView.backgroundColor = flashCard.bottomBackgroundColor
        
        termLabel.attributedText = .create(string: flashCard.front,
                                           font:  FontManager.shared.primaryFont(style: .bold, size: 15),
                                           color: flashCard.fontColor)
        
        defLabel.attributedText = .create(string: flashCard.back,
                                          font: FontManager.shared.primaryFont(style: .semiBold, size: 12),
                                          color: flashCard.fontColorSecondary)
    }
}
