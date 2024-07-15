//
//  TopicMapHeaderViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/9/24.
//

import Foundation

import UIKit

class TopicMapHeaderViewCell: UICollectionViewCell{
    
    lazy var headerView: UIView = {
       let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var sectionTitle: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
       // v.font = UIFont(name: "HelveticaNeue-Italic", size: 15)
        //v.textColor = UIColor.darkGray
        

        return v
    }()
    
    lazy var collapseButton: UIButton = {
        var cButton = UIButton()
        cButton.translatesAutoresizingMaskIntoConstraints = false
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

extension TopicMapHeaderViewCell{
    private func setup(){
        contentView.addSubview(headerView)
        headerView.addSubview(sectionTitle)
        headerView.addSubview(collapseButton)
        setupMainConstraints()
    }
    
    private func setupMainConstraints(){
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            sectionTitle.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            sectionTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            sectionTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            sectionTitle.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5),
            
            collapseButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            collapseButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            collapseButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            collapseButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor,constant: -5),
            
        ])
    }
    
    func configureTopicHeader(title: String){
       // headerView.backgroundColor = ColorManager.shared.currentTheme.colors.backGroundColor
        contentView.backgroundColor = ColorManager.shared.currentTheme.colors.backGroundColor
        sectionTitle.font =  UIFont.systemFont(ofSize: 14)
        sectionTitle.textColor = ColorManager.shared.currentTheme.colors.fontColor
        sectionTitle.text = title
        
        
    }
}

