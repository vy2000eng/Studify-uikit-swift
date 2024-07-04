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
        v.backgroundColor = .systemBackground
        return v
    }()
    
    lazy var collapseButton:UIButton = {
        var cButton = UIButton()
        cButton.translatesAutoresizingMaskIntoConstraints = false
        cButton.backgroundColor = .systemBackground
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
                headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                collapseButton.topAnchor.constraint(equalTo: headerView.topAnchor),
                collapseButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        
        
        
    }
}
