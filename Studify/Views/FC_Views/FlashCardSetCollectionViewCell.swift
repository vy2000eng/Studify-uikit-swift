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
        mainView.backgroundColor = warmTreeTones.lightTertiary!.withAlphaComponent(0.5)
        mainView.layer.cornerRadius = 2
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainView.layer.shadowRadius = 4
        mainView.layer.shadowOpacity = 0.1
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
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
    
    var tightConstraints: [NSLayoutConstraint] = []
      var relaxedConstraints: [NSLayoutConstraint] = []
    
    override func prepareForReuse() {
        print("prepare for reuse")
        
        super.prepareForReuse()
        return mainView.backgroundColor = warmTreeTones.lightTertiary!.withAlphaComponent(0.5)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
        setupConstraints()
        configureConstraints()
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
        //    mainView.topAnchor.constraint(equalTo: topAnchor,constant: 40),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            termLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),

          
        ])
        relaxedConstraints = [
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 40),

            termLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            vstack.topAnchor.constraint(equalTo: termLabel.bottomAnchor, constant: 5),
            vstack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            vstack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            vstack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
        ]
        
        tightConstraints = [
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            
            termLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            vstack.topAnchor.constraint(equalTo: termLabel.bottomAnchor, constant: 5),
            vstack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
            vstack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            vstack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant:  -5),
        ]
    }
    
    func configureConstraints() {
        // Start with all constraints deactivated
        NSLayoutConstraint.deactivate(relaxedConstraints + tightConstraints)

        // Activate the initial constraint set based on some initial condition
        NSLayoutConstraint.activate(relaxedConstraints)
    }

    
    func configure(flashcard: FlashcardViewModel, bottomTopStyle:Int ){
        let termLabelFontSize : CGFloat = bottomTopStyle == 0 ? 12 : 8
        
        let text = flashcard.isShowingFront ? flashcard.front : flashcard.back
        termText.text = text
        
        let fontSize = determineFontSize(for: text, topBottomStyle:  bottomTopStyle)
        termText.font = UIFont(name: "Helvetica", size: fontSize)
        termLabel.font = UIFont(name: "Helvetica-Bold", size: termLabelFontSize)
        termLabel.text = flashcard.isShowingFront ? "term" : "def"
        termText.font = UIFont(name:"Helvetica", size: fontSize)
        termText.text = flashcard.isShowingFront ? flashcard.front : flashcard.back
        
        NSLayoutConstraint.deactivate(bottomTopStyle == 0 ? tightConstraints : relaxedConstraints)
        NSLayoutConstraint.activate(bottomTopStyle == 0 ? relaxedConstraints : tightConstraints)
        
    }
    private func determineFontSize(for text: String, topBottomStyle:Int) -> CGFloat {
       
        let length = text.count
        if length > 50 {
            return 12 // Smaller text for longer content
        } else if length > 20 {
            return topBottomStyle == 0 ? 15 : 12 // Medium text for medium-length content
        } else {
            return topBottomStyle == 0 ? 18: 15 // Larger text for shorter content
        }
    }
}

