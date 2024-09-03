//
//  FlashCardGameCollectionViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/21/24.
//

import Foundation
import SwipeCellKit
import UIKit
class FlashCardGameCollectionViewCell:UIView{
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
    
    lazy var vstack: UIStackView = {
        
        let vstack = UIStackView()
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.alignment = .leading
        vstack.distribution = .fill
        vstack.spacing = 10
        return vstack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        layer.borderWidth = 8
        layer.cornerRadius = 2
        
        addSubview(mainView)
        mainView.addSubview(termLabel)
        mainView.addSubview(vstack)
        vstack.addArrangedSubview(termText)
        setupConstraints()
        
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 8),

            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            termLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),


            termLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            
            vstack.topAnchor.constraint(equalTo: termLabel.bottomAnchor, constant: 5),
            vstack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            vstack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            vstack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
        ])
        
    }
    
    func configure(flashcard: FlashcardViewModel, bottomTopStyle:Int ){
        
        layer.borderColor = flashcard.background.cgColor
        backgroundColor = flashcard.background

        let termLabelFontSize : CGFloat = bottomTopStyle == 0 ? 12 : 8
        
        mainView.layer.borderColor = ColorManager.shared.currentTheme.colors.backGroundColor == .black
        ? UIColor.white.withAlphaComponent(0.1).cgColor
        : UIColor.black.withAlphaComponent(0.1).cgColor
      
        mainView.backgroundColor = flashcard.topBackgroundColor
        
        
        let text = flashcard.isShowingFront ? flashcard.front : flashcard.back
        let fontSize = determineFontSize(for: text, topBottomStyle:  bottomTopStyle)

        termLabel.attributedText = .create(string: flashcard.isShowingFront ? "term" : "def",
                                           font: FontManager.shared.primaryFont(style: .semiBold, size: termLabelFontSize),
                                           color: flashcard.fontColor)
        
        termText.attributedText = .create(string: text,
                                          font: FontManager.shared.primaryFont(style: .regular, size: fontSize),
                                          color: flashcard.fontColorSecondary)

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

extension FlashCardGameCollectionViewCell{
    
    
}
