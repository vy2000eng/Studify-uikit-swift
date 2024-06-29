//
//  FlashCardSetCollectionViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/22/24.
//

import UIKit

class FlashCardSetCollectionViewCell: UICollectionViewCell {
    
    lazy var termLabel: UILabel = {
        
        let termLabel = UILabel()
        termLabel.translatesAutoresizingMaskIntoConstraints = false
        return termLabel
    }()
    lazy var termText: UILabel = {
        
        let termText = UILabel()
        termText.translatesAutoresizingMaskIntoConstraints = false
        termText.numberOfLines = 0
        termText.adjustsFontSizeToFitWidth = true
        termText.minimumScaleFactor = 0.5
        return termText
    }()
    
    lazy var countLabel: UILabel = {
       
        let countLabel = UILabel()
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.font = UIFont(name: "helvetica", size: 8)
        return countLabel
    }()
    
    lazy var mainView: UIView = {
       
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = warmTreeTones.lightTertiary
        mainView.layer.cornerRadius = 2
        return mainView
    }()
    
    lazy var vstack: UIStackView = {
        
        let vstack = UIStackView()
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.alignment = .leading
        vstack.distribution = .fill
        vstack.spacing = 10
        return vstack
    }()
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        return mainView.backgroundColor = warmTreeTones.lightTertiary
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlashCardSetCollectionViewCell{
    private func setup(){
        
        contentView.addSubview(mainView)
        mainView.addSubview(termLabel)
        mainView.addSubview(vstack)
        vstack.addArrangedSubview(termText)
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor,constant: 40),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            termLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            termLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),

            vstack.topAnchor.constraint(equalTo: termLabel.bottomAnchor, constant: 5),
            vstack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            vstack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            vstack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure(flashcard: FlashcardViewModel, bottomTopStyle:Int ){
       
        let text = flashcard.isShowingFront ? flashcard.front : flashcard.back
        termText.text = text
        
        let fontSize = determineFontSize(for: text)
        termText.font = UIFont(name: "Helvetica", size: fontSize)
        
        if bottomTopStyle == 0{
            termLabel.font = UIFont(name: "Helvetica-Bold", size: 12)
            termLabel.text = flashcard.isShowingFront ? "term" : "def"
            termText.font = UIFont(name:"Helvetica", size: fontSize)
            termText.text = flashcard.isShowingFront ? flashcard.front : flashcard.back
            
        }
        else{
            NSLayoutConstraint.deactivate([
                termLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
                vstack.topAnchor.constraint(equalTo: termLabel.bottomAnchor, constant: 5),
                vstack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
                vstack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
                vstack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
            
            ])
            
            NSLayoutConstraint.activate([
                termLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
                vstack.topAnchor.constraint(equalTo: termLabel.bottomAnchor, constant: 5),
                vstack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
                vstack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
                vstack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant:  -5),
            
            
            ])

            termLabel.font = UIFont(name: "Helvetica-Bold", size: 8)
            termText.font = UIFont(name:"Helvetica", size:12)

            termLabel.text = flashcard.isShowingFront ? "term" : "def"
            termText.text = flashcard.isShowingFront ? flashcard.front : flashcard.back
        }
    }
    private func determineFontSize(for text: String) -> CGFloat {
       
        let length = text.count
        if length > 50 {
            return 12  // Smaller text for longer content
        } else if length > 20 {
            return 15  // Medium text for medium-length content
        } else {
            return 18  // Larger text for shorter content
        }
    }
}

