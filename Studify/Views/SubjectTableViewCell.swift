//
//  SubjectTableViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/3/24.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {
    
    lazy var subjectNameLabel: UILabel = {
        let label = UILabel()
       // label.backgroundColor = OceanSandTheme.darkPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Georgia-Bold", size: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var createdOnLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        //label.textColor = UIColor.darkGray  // Good for general use



        return label
    }()
    
    lazy var TopicsCountLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 10)
            // label.textColor = UIColor.darkGray  // Good for general use


        return label
    }()
    
    lazy var MapsCountLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 10)


        return label
    }()
    

    lazy var subContentView:UIView = {
       let subContentView = UIView()
        subContentView.translatesAutoresizingMaskIntoConstraints = false
        subContentView.layer.cornerRadius = 2
        subContentView.backgroundColor = OceanSandTheme.lightSecondary
        return subContentView
    }()

    lazy var topContentView: UIView = {
        let topContentView = UIView()
        topContentView.translatesAutoresizingMaskIntoConstraints = false
        topContentView.layer.cornerRadius = 2
        topContentView.backgroundColor = OceanSandTheme.darkPrimary
        return topContentView
    }()
    
    lazy var mainContentView: UIView = {
       let mainContentView = UIView()
        mainContentView.translatesAutoresizingMaskIntoConstraints = false
        mainContentView.backgroundColor = UIColor.white
        mainContentView.layer.shadowOffset = CGSize(width: 5, height: 5);
        mainContentView.layer.shadowOpacity = 0.30;
        mainContentView.layer.shadowRadius = 1.0;
        mainContentView.layer.borderWidth = 1
        mainContentView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        mainContentView.layer.cornerRadius = 2
        
        return mainContentView
        
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SubjectTableViewCell{
    
    private func setup(){
        selectionStyle = .none
        backgroundColor = UIColor.white
        contentView.addSubview(mainContentView)
        mainContentView.addSubview(topContentView)
        mainContentView.addSubview(subContentView)
        topContentView.addSubview(subjectNameLabel)
        subContentView.addSubview(TopicsCountLabel)
        subContentView.addSubview(MapsCountLabel)
        subContentView.addSubview(createdOnLabel)
        setupMainConstraints()
    }
    private func setupMainConstraints(){
        NSLayoutConstraint.activate([
            
            mainContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            mainContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            mainContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            mainContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            topContentView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 4),
            topContentView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -4),
            topContentView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 4),
            
            subContentView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 4),
            subContentView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -4),
            subContentView.topAnchor.constraint(equalTo: topContentView.bottomAnchor,constant: 2),
            subContentView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -4)
        ])
        
        setupConstraints()
    }
    
    private func setupConstraints(){

        NSLayoutConstraint.activate([
     
              subjectNameLabel.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 8),
              subjectNameLabel.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor, constant:-8),
              subjectNameLabel.topAnchor.constraint(equalTo: topContentView.topAnchor, constant: 8),
              subjectNameLabel.bottomAnchor.constraint(equalTo: topContentView.bottomAnchor, constant: -8),
              
              TopicsCountLabel.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor,constant: 4),
              TopicsCountLabel.topAnchor.constraint(equalTo: subContentView.topAnchor, constant: 12),
              TopicsCountLabel.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor, constant: -4),
              
              MapsCountLabel.topAnchor.constraint(equalTo: TopicsCountLabel.bottomAnchor, constant: 8),
              MapsCountLabel.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor,constant: 4),
              MapsCountLabel.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor, constant: -4),
              MapsCountLabel.bottomAnchor.constraint(equalTo: subContentView.bottomAnchor, constant: -6),
              
              createdOnLabel.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor, constant: -4),
              createdOnLabel.bottomAnchor.constraint(equalTo: subContentView.bottomAnchor, constant: -6)
              
        ])
    }
    
    func configure(with subject:SubjectViewModel){
         subjectNameLabel.text = subject.name
        
        let topicAttrString = configureString(subject: subject, topicOrMap: 0)
        TopicsCountLabel.attributedText = topicAttrString
   
        let mapsAttrString = configureString(subject: subject, topicOrMap: 1)
        MapsCountLabel.attributedText = mapsAttrString
        
        let createdOnAttrString = configureString(subject: subject, topicOrMap: 2)
        createdOnLabel.attributedText = createdOnAttrString

        
    }
    
    func configureString(subject: SubjectViewModel, topicOrMap : Int) -> NSMutableAttributedString{
        let grayTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        let attrString = NSMutableAttributedString(string: "")
        let attachment = NSTextAttachment()
        let pinOrList = topicOrMap == 0 ? "text.bubble" : topicOrMap == 1 ? "mappin"  : "clock"
        
        if let image =  UIImage(systemName: pinOrList)?.withTintColor(topicOrMap == 0 ?  UIColor.black : topicOrMap == 1 ? UIColor.systemRed : UIColor.black ){
            attachment.image = image
        }
        
        attachment.bounds = CGRect(x: 0, y: -2, width: 20, height: 20)
        attrString.append(NSAttributedString(attachment: attachment))
        let topicOrMapCountOrCreateOn = topicOrMap == 0 ? "\(subject.topicsCount)" : topicOrMap == 1 ? "\(subject.mapsCount)" : "\(subject.createdOn.formatted(date: .abbreviated, time: .omitted))"
        
        attrString.append(NSAttributedString(string: " \(topicOrMapCountOrCreateOn)",attributes: grayTextAttributes))
        
        return attrString
        
    }
    
}


