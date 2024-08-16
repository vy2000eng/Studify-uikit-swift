//
//  GameConclusionView.swift
//  Studify
//
//  Created by VladyslavYatsuta on 8/3/24.
//

import Foundation
import UIKit







class GameConclusionView: UIView{
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkSlateGrey
        view.layer.cornerRadius = 1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.1
        return view
    }()
    
    
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
        //        addSubview(conclusionLabelStack)
        //        conclusionLabelStack.addArrangedSubview(learnedFlashCardsLabel)
        //        conclusionLabelStack.addArrangedSubview(stillLearningFlashCardLabel)
        //        conclusionLabelStack.addArrangedSubview(scoreLabel)
        //        conclusionLabelStack.addArrangedSubview(buttonStack)
        //        buttonStack.addArrangedSubview(saveButton)
        //        buttonStack.addArrangedSubview(resetButton)
        
        addSubview(containerView)
        containerView.addSubview(conclusionLabelStack)
        conclusionLabelStack.addArrangedSubview(learnedFlashCardsLabel)
        conclusionLabelStack.addArrangedSubview(stillLearningFlashCardLabel)
        conclusionLabelStack.addArrangedSubview(scoreLabel)
        conclusionLabelStack.addArrangedSubview(buttonStack)
        buttonStack.addArrangedSubview(saveButton)
        buttonStack.addArrangedSubview(resetButton)
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            conclusionLabelStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            conclusionLabelStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            conclusionLabelStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            conclusionLabelStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
            
            buttonStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configure(numberOfLearnedFlashCards:Int, numberOfStillLearningFlashCards: Int, viewmodel: FlashCardGameViewModel){
        
        
        let num = (Float(numberOfLearnedFlashCards)/Float(viewmodel.numberOfGameFlashCards))*100
        let formattedNum = String(format: "%.0f", num)
        
        conclusionLabelStack.backgroundColor = .darkSlateGrey
        
        
        let learnedFlashCardsAttributedString =
        createAttributedString(string:"You have Learned: \(numberOfLearnedFlashCards)",
                               font: viewmodel.titleFont,
                               color: viewmodel.fontColor)
        
        
        let stillLearningFlashCardsAttributedString =
        createAttributedString(string:"You Are Still Learning: \(numberOfStillLearningFlashCards)",
                               font: viewmodel.titleFont,
                               color: viewmodel.fontColor)

        
        let scoredLabelAttributedString =
        createAttributedString(string:"Your Score: \(formattedNum)%",
                               font: viewmodel.titleFont,
                               color: viewmodel.fontColor)
        
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
    
    private func createAttributedString(string: String, font: UIFont, color: UIColor) -> NSAttributedString {
          return NSAttributedString(string: string, attributes: [.font: font, .foregroundColor: color])
      }
    
}
