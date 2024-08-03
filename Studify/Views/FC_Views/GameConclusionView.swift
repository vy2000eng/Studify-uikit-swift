//
//  GameConclusionView.swift
//  Studify
//
//  Created by VladyslavYatsuta on 8/3/24.
//

import Foundation
import UIKit


class GameConclusionView: UIView{
    let numberOfLearnedFlashCards:Int
    let numberOfStillLearningFlashCards: Int
    
    
    lazy var conclusionLabel:UILabel = {
        let label = UILabel()
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
    
    
    
    
    init(numberOfLearnedFlashCards: Int, numberOfStillLearningFlashCards: Int, frame:CGRect){
        self.numberOfLearnedFlashCards = numberOfLearnedFlashCards
        self.numberOfStillLearningFlashCards = numberOfStillLearningFlashCards
        super.init(frame: .zero)
        setup()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
extension GameConclusionView{
    private func setup(){
        addSubview(conclusionLabel)
        addSubview(learnedFlashCardsLabel)
        addSubview(stillLearningFlashCardLabel)
        addSubview(saveButton)
        addSubview(resetButton)

        
        
    }
    private func setupConstraints(){
        
    }
    
    
}
