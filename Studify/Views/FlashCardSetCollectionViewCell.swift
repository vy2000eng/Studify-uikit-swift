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
        return termText
    }()
    
    lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = OceanSandTheme.darkPrimary
        mainView.layer.cornerRadius = 2
        
        return mainView
        
        
    }()
    
    lazy var vstack: UIStackView = {
       let vstack = UIStackView()
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.alignment = .leading
        vstack.distribution = .fill
        return vstack
    }()
    
    
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
       // contentView.addSubview(vstack)
        
        mainView.addSubview(termLabel)
        mainView.addSubview(vstack)
        vstack.addArrangedSubview(termText)
        
        //mainView.addSubview(termText)
        setupConstraints()

    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            termLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            termLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),

            vstack.topAnchor.constraint(equalTo: termLabel.bottomAnchor, constant: 10),
            vstack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            vstack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            vstack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),

        ])

        
    }
    
    func configure(flashcard: FlashcardViewModel){
        termLabel.text = "term"
        termText.text = flashcard.front

    }
}

