//
//  FlashcardSmallSetViewControllerHeader.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/4/24.
//

import Foundation
import UIKit
class FlashcardSmallSetViewControllerHeader: UICollectionViewCell{
    lazy var headerView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
       // v.backgroundColor = .lightGray.withAlphaComponent(0.5)
    
        
        
        return v
    }()
    
    lazy var collapseButton:UIButton = {
        var cButton = UIButton()
        cButton.translatesAutoresizingMaskIntoConstraints = false
       // cButton.backgroundColor = .lightGray
        cButton.layer.cornerRadius = 2
          cButton.tintColor = .darkGray
          cButton.backgroundColor = .systemBackground
         // cButton.layer.cornerRadius = 15
          cButton.layer.shadowColor = UIColor.black.cgColor
          cButton.layer.shadowOffset = CGSize(width: 0, height: 1)
          cButton.layer.shadowOpacity = 0.2
          cButton.layer.shadowRadius = 2
        return cButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlashcardSmallSetViewControllerHeader{
    private func setup(){
        contentView.addSubview(headerView)
        headerView.addSubview(collapseButton)
        setupConstraints()
    }
    private func setupConstraints(){
        
            NSLayoutConstraint.activate([
                headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
                headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
                headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
               
                collapseButton.topAnchor.constraint(equalTo: headerView.topAnchor),
                collapseButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        
        
        
    }
}
