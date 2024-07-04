//
//  FlashCardListCollectionViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/25/24.
//

import Foundation
import UIKit

class FlashCardListCollectionViewCell: UICollectionViewCell {
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
        topContentView.layer.cornerRadius = 2
        topContentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]  // Top left and top right

        topContentView.backgroundColor = warmTreeTones.lightPrimary

        return topContentView
    }()
    lazy var bottomContentView: UIView = {
        let bottomContentView = UIView()
        bottomContentView.translatesAutoresizingMaskIntoConstraints = false
        bottomContentView.backgroundColor = warmTreeTones.lightSecondary
        bottomContentView.layer.cornerRadius = 2
        bottomContentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]   // Top left and top right

        
        return bottomContentView
    }()
 

    lazy var mainView: UIView = {
       let mainView = UIView()
    //    mainView.backgroundColor = warmTreeTones.darkPrimary
        mainView.translatesAutoresizingMaskIntoConstraints = false
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
            
            
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 2),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
            topContentView.topAnchor.constraint(equalTo: mainView.topAnchor,constant: 5),
            topContentView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 5),
            topContentView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -5),
            //topContentView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            
            bottomContentView.topAnchor.constraint(equalTo: topContentView.bottomAnchor),
            bottomContentView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
            bottomContentView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -5),
            bottomContentView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            
            
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
        termLabel.text = flashCard.front
        termLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        defLabel.text = flashCard.back
        defLabel.font = UIFont(name: "Helvetica", size: 12)
    }
    
}
