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
        return termText
    }()
    
    lazy var mainView: UIView = {
        let mainView = UIView()
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

extension FlashCardSetCollectionViewCell{
    private func setup(){
        contentView.addSubview(mainView)
        mainView.addSubview(termLabel)
        mainView.addSubview(termText)
        setupConstraints()

    }
    private func setupConstraints(){
        
    }
}

