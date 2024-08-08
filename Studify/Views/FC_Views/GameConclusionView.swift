//
//  GameConclusionView.swift
//  Studify
//
//  Created by VladyslavYatsuta on 8/3/24.
//

import Foundation
import UIKit







class GameConclusionView: UIView{
    lazy var conclusionLabelStack:UIStackView = {
        let label = UIStackView()
        label.axis = .vertical
        label.distribution = .equalSpacing
        label.spacing = 15
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
  
    lazy var learnedFlashCardsLabel = createLabel()
    lazy var stillLearningFlashCardLabel = createLabel()
    lazy var scoreLabel = createLabel()
    lazy var buttonLabel = createLabel()
    lazy var saveButton = createButton(title: "Save FlashCards")
    lazy var resetButton = createButton(title: "Reset FlashCards")

    
    override init(frame:CGRect){
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GameConclusionView{
    private func setup(){
       // ..addSubview(containerView)
       // containerView.addSubview(conclusionLabelStack)
        addSubview(conclusionLabelStack)
        conclusionLabelStack.addArrangedSubview(learnedFlashCardsLabel)
        conclusionLabelStack.addArrangedSubview(stillLearningFlashCardLabel)
        conclusionLabelStack.addArrangedSubview(scoreLabel)
        conclusionLabelStack.addArrangedSubview(buttonStack)
        buttonStack.addArrangedSubview(saveButton)
        buttonStack.addArrangedSubview(resetButton)

    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            conclusionLabelStack.topAnchor.constraint(equalTo: topAnchor),
            conclusionLabelStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            conclusionLabelStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            conclusionLabelStack.bottomAnchor.constraint(equalTo: bottomAnchor),
 
        ])
    }
    
    func configure(numberOfLearnedFlashCards:Int, numberOfStillLearningFlashCards: Int, viewmodel: FlashCardGameViewModel){
        
        conclusionLabelStack.backgroundColor = .darkSlateGrey
        
        let learnedFlashCardsAttributedString = NSAttributedString(
            string: "You have Learned \(numberOfLearnedFlashCards)",
            attributes: [.font: viewmodel.titleFont, .foregroundColor: viewmodel.fontColor])
        
        let stillLearningFlashCardsAttributedString = NSAttributedString(
            string: "You Are Still Learning \(numberOfStillLearningFlashCards)",
            attributes: [.font: viewmodel.titleFont, .foregroundColor: viewmodel.fontColor])
        
        let scoredLabelAttributedString = NSAttributedString(
            string: "your Score: (TODO CHANGE 100 %)",
            attributes: [.font: viewmodel.titleFont, .foregroundColor: viewmodel.fontColor])
        
        
        stillLearningFlashCardLabel.attributedText = learnedFlashCardsAttributedString
        learnedFlashCardsLabel.attributedText = stillLearningFlashCardsAttributedString
        scoreLabel.attributedText = scoredLabelAttributedString
        
        
        saveButton.titleLabel?.font = viewmodel.subtitleFont
        resetButton.titleLabel?.font = viewmodel.subtitleFont
   
        
    }
}

extension GameConclusionView{
    
    private func createLabel() -> UILabel {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textAlignment = .center
      label.numberOfLines = 0
      return label
  }
  
  private func createButton(title: String) -> UIButton {
      let button = UIButton(type: .system)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitle(title, for: .normal)
      button.backgroundColor = .systemBlue
      button.setTitleColor(.white, for: .normal)
      button.layer.cornerRadius = 10
      return button
  }
    
}
