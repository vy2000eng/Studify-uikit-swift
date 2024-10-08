//
//  SubjectTopicViewCellTableViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import UIKit
import SwipeCellKit

class TopicViewCell: SwipeCollectionViewCell {
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

     lazy var topicNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        return label
    }()

     lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()

    lazy var createdOnLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()

    lazy var mainContentView: UIView = {
        let mainContentView = UIView()
        mainContentView.translatesAutoresizingMaskIntoConstraints = false

        mainContentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        mainContentView.layer.shadowOpacity = 0.2
        mainContentView.layer.shadowRadius = 1.0
        mainContentView.layer.borderWidth = 2
        mainContentView.layer.cornerRadius = 2
        return mainContentView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
   

        contentView.addSubview(mainContentView)
        mainContentView.addSubview(stackView)
        
        stackView.addArrangedSubview(topicNameLabel)
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(createdOnLabel)
        
        NSLayoutConstraint.activate([
            mainContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            mainContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            mainContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
            
            stackView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with topic: TopicViewModel) {
        mainContentView.layer.borderColor = ColorManager.shared.currentTheme.colors.backGroundColor == .black 
        ?  UIColor.white.withAlphaComponent(0.1).cgColor
        :  UIColor.black.withAlphaComponent(0.1).cgColor
        
        mainContentView.backgroundColor = topic.backGroundColor
        
        topicNameLabel.attributedText = .create(string: topic.title, font: topic.titleFont, color: topic.fontColor)
        countLabel.attributedText = .create(string: "📄 \(topic.topicCount) flashcards", font: topic.subtitleFont, color: topic.fontColorSecondary)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let formattedDate = dateFormatter.string(from: topic.createdOn)
        createdOnLabel.attributedText = .create(string: "🕒 \(formattedDate)", font: topic.subtitleFont, color: topic.fontColorSecondary)
    }
}

//MARK: just here for reference
//class TopicViewCell: SwipeCollectionViewCell {
//
// 
//    lazy var topicNameLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Georgia-Bold", size: 15)
//        label.textColor = UIColor.white
//
//        return label
//    }()
//    
//    lazy var createdOnLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "HelveticaNeue", size: 10)
//      //  label.textColor = UIColor.darkGray  // Good for general use
//        label.numberOfLines = 0
//
//
//
//        return label
//    }()
//    
//    lazy var countLabel:UILabel = {
//       let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "HelveticaNeue", size: 10)
//        label.numberOfLines = 0
//      //  label.textColor = UIColor.darkGray  // Good for general use
//
//
//        return label
//    }()
//    
//    
//    lazy var topContentView: UIView = {
//       let topContentView = UIView()
//        topContentView.translatesAutoresizingMaskIntoConstraints = false
//        topContentView.layer.cornerRadius = 2
//        topContentView.backgroundColor = warmClouds.darkPrimary
//        return topContentView
//    }()
//    
//    lazy var subContentView:UIView = {
//        let subContentView = UIView()
//        subContentView.translatesAutoresizingMaskIntoConstraints = false
//        subContentView.layer.cornerRadius = 2
//        subContentView.backgroundColor = warmClouds.lightTertiary
//        return subContentView
//    }()
//   
//    
//    lazy var mainContentView: UIView = {
//       let mainContentView = UIView()
//        mainContentView.translatesAutoresizingMaskIntoConstraints = false
//        mainContentView.backgroundColor = UIColor.white
//        mainContentView.layer.shadowOffset = CGSize(width: 5, height: 5);
//        mainContentView.layer.shadowOpacity = 0.30;
//        mainContentView.layer.shadowRadius = 1.0;
//        mainContentView.layer.borderWidth = 1
//        mainContentView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
//        mainContentView.layer.cornerRadius = 2
//        return mainContentView
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//
//}
//
//extension TopicViewCell{
//    
//    private func setup(){
//        backgroundColor = UIColor.white
//        contentView.addSubview(mainContentView)
//
//
//        mainContentView.addSubview(topContentView)
//        mainContentView.addSubview(subContentView)
//        topContentView.addSubview(topicNameLabel)
//        subContentView.addSubview(createdOnLabel)
//        subContentView.addSubview(countLabel)
//        setupMainConstraints()
//    }
//    
//    private func setupMainConstraints(){
//        NSLayoutConstraint.activate([
//            //MARK: maincontent view
//            mainContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
//            mainContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
//            mainContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
//            mainContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
//            
//            //MARK: topContent view
//            topContentView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 4),
//            topContentView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 4),
//            topContentView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -4),
//            
//            //MARK: subcontent view
//            subContentView.topAnchor.constraint(equalTo: topContentView.bottomAnchor,constant: 2),
//            subContentView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 4),
//            subContentView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -4),
//            subContentView.bottomAnchor.constraint(lessThanOrEqualTo: mainContentView.bottomAnchor, constant: -4),// changed this
//            
//            //MARK: topicname label
//            topicNameLabel.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 8),
//            topicNameLabel.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor, constant:-8),
//            topicNameLabel.topAnchor.constraint(equalTo: topContentView.topAnchor, constant: 8),
//            topicNameLabel.bottomAnchor.constraint(equalTo: topContentView.bottomAnchor, constant: -8),
//            
//            //MARK: count  label
//            countLabel.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor, constant: 4),
//            countLabel.topAnchor.constraint(equalTo: subContentView.topAnchor, constant: 12),
//            countLabel.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor, constant:  -4),
//            
//            //MARK: createOn label
//            createdOnLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 8),
//            createdOnLabel.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor, constant:4),
//            createdOnLabel.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor, constant: -4),
//            createdOnLabel.bottomAnchor.constraint(equalTo: subContentView.bottomAnchor, constant: -6),
//                        
//        ])
//        
//    }
//
//
//    
//    func configure(with topic: TopicViewModel){
//        topicNameLabel.text = topic.title
//        let fcAttrString = configureString(topic: topic, flashCardOrCreatedOn:  0)
//        countLabel.attributedText = fcAttrString
//        
//        let createdOnAttrString = configureString(topic: topic, flashCardOrCreatedOn: 1)
//        createdOnLabel.attributedText = createdOnAttrString
//    }
//    
//    // which label are we configuring? createdOn(0) or flashcard count(1)
//    func configureString(topic:TopicViewModel, flashCardOrCreatedOn: Int)  -> NSMutableAttributedString{
//
//        let attrString = NSMutableAttributedString(string: "")
//        let attachment = NSTextAttachment()
//        let cardOrClock = flashCardOrCreatedOn == 0 ? "doc" : "clock"
//        
//        if let image = UIImage(systemName: cardOrClock)?.withTintColor(UIColor.black){
//            attachment.image = image
//        }
//
//        attachment.bounds = flashCardOrCreatedOn == 0 ? CGRect(x: 0, y: -2, width: 15, height: 17) : CGRect(x: 0, y: -2, width: 15, height: 15)
//        attrString.append(NSAttributedString(attachment: attachment))
//        let fcOrCreatedOn = flashCardOrCreatedOn == 0 ? "\(topic.topicCount)" : "\(topic.createdOn.formatted(date:.abbreviated, time:.shortened))"
//        attrString.append(NSAttributedString(string: " \(fcOrCreatedOn)"))
//        
//        return attrString
//    }
//}
//
