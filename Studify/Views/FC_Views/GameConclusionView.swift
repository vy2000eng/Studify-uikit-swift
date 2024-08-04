//
//  GameConclusionView.swift
//  Studify
//
//  Created by VladyslavYatsuta on 8/3/24.
//

import Foundation
import UIKit


class GameConclusionView: UIView{
//    let numberOfLearnedFlashCards:Int
//    let numberOfStillLearningFlashCards: Int
    
    
    lazy var conclusionLabelStack:UIStackView = {
        let label = UIStackView()
        label.axis = .vertical
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var learnedFlashCardsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()    
    
    lazy var stillLearningFlashCardLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scoreLabel:UILabel = {
       let scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        return scoreLabel
    }()
    
    lazy var buttonLabel:UILabel = {
        let buttonLabel = UILabel()
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        return buttonLabel
    }()
    
    lazy var saveButton:UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()
    
    lazy var resetButton:UIButton = {
       let resetButton = UIButton()
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        return resetButton
    }()
    
    override init(frame:CGRect){
        
       // self.numberOfLearnedFlashCards = numberOfLearnedFlashCards
       // self.numberOfStillLearningFlashCards = numberOfStillLearningFlashCards

        super.init(frame: .zero)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
extension GameConclusionView{
    private func setup(){
        
        addSubview(conclusionLabelStack)
        conclusionLabelStack.addArrangedSubview(learnedFlashCardsLabel)
        conclusionLabelStack.addArrangedSubview(stillLearningFlashCardLabel)
        conclusionLabelStack.addArrangedSubview(scoreLabel)
        buttonLabel.addSubview(saveButton)
        buttonLabel.addSubview(resetButton)
        conclusionLabelStack.addArrangedSubview(buttonLabel)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            conclusionLabelStack.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            conclusionLabelStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            conclusionLabelStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            conclusionLabelStack.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: buttonLabel.topAnchor, constant: 10),
            saveButton.leadingAnchor.constraint(equalTo: buttonLabel.leadingAnchor, constant: 10),
            saveButton.bottomAnchor.constraint(equalTo: buttonLabel.bottomAnchor, constant: -10),
            
            resetButton.topAnchor.constraint(equalTo: buttonLabel.topAnchor, constant: 10),
            resetButton.trailingAnchor.constraint(equalTo: buttonLabel.trailingAnchor, constant: 10),
            resetButton.bottomAnchor.constraint(equalTo: buttonLabel.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(numberOfLearnedFlashCards:Int, numberOfStillLearningFlashCards: Int, viewmodel: FlashCardGameViewModel){
        
        let learnedFlashCardsAttributedString = NSAttributedString(
            string: "You have Learned \(numberOfLearnedFlashCards)",
            attributes: [.font: viewmodel.titleFont, .foregroundColor: viewmodel.fontColor])
        
        let stillLearningFlashCardsAttributedString = NSAttributedString(
            string: "You Are Still Learning \(numberOfStillLearningFlashCards)",
            attributes: [.font: viewmodel.titleFont, .foregroundColor: viewmodel.fontColor])
        
        let saveButtonAttributedText = NSAttributedString(
            string: "save current flashCards",
            attributes: [.font: viewmodel.titleFont, .foregroundColor: viewmodel.fontColor])
        
        let resetButtonAttributedText = NSAttributedString(
            string: "reset current flashCards",
            attributes: [.font: viewmodel.titleFont, .foregroundColor: viewmodel.fontColor])

        stillLearningFlashCardLabel.attributedText = learnedFlashCardsAttributedString
        learnedFlashCardsLabel.attributedText = learnedFlashCardsAttributedString
        saveButton.setAttributedTitle(saveButtonAttributedText, for: .normal)
        resetButton.setAttributedTitle(resetButtonAttributedText, for: .normal)
        
    }
}
