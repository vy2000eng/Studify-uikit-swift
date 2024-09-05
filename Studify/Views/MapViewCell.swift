//
//  SubjectMapViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//

import UIKit
// The reason were using swipeCellKit is because compisition layout doesnt support swipe actions.
// Making them yourself with pangestures is like an ungodly amount of work.
// If I was making swipeCellKit then I'd figure it out, but I just need good looking swipe gesture.
//MARK: The reason were using compostional layout is because it's the only way i've tried that makes the header buttons look good and work correctly when adding, deleting


//import SwipeCellKit

class MapViewCell:  TopicViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
     
}
extension MapViewCell{
    func configure(with map: MapViewModel){
       
        mainContentView.layer.borderColor = ColorManager.shared.currentTheme.colors.backGroundColor == .black
        ?  UIColor.white.withAlphaComponent(0.1).cgColor
        :  UIColor.black.withAlphaComponent(0.1).cgColor
        
        //mainContentView.backgroundColor = map.backGroundColor
        
        topicNameLabel.attributedText = .create(string: map.title, font: map.titleFont, color: map.fontColor)
       // countLabel.attributedText = .create(string: "📍 \(map.mindMapCount) maps", font: map.subtitleFont, color: map.fontColorSecondary)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let formattedDate = dateFormatter.string(from: map.createdOn)
        createdOnLabel.attributedText = .create(string: "🕒 \(formattedDate)", font: map.subtitleFont, color: map.fontColorSecondary)
    }
}


//MARK: just here for reference:
//        mainContentView.backgroundColor = map.backGroundColor
//        topicNameLabel.textColor = map.fontColor
//        countLabel.textColor = map.fontColorSecondary
//        createdOnLabel.textColor = map.fontColorSecondary
//
//        topicNameLabel.text = map.title
//        countLabel.text = "📍 \(map.mindMapCount) maps"
//        createdOnLabel.text = "🕒 \(map.createdOn.formatted(date: .numeric, time: .omitted)) at \(map.createdOn.formatted(date: .omitted, time: .shortened))"

    
//MARK: just here for referernce
//    lazy var mapsNameLabel: UILabel = {
//       let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Georgia-Bold", size: 15)
//        label.textColor = UIColor.white
//
//        return label
//    }()
//    
//    lazy var createdOnLabel : UILabel = {
//       let v = UILabel()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.font = UIFont(name: "HelveticaNeue", size: 10)
//
//        return v
//    }()
//    
//    lazy var countLabel: UILabel = {
//       let v = UILabel()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.font = UIFont(name: "HelveticaNeue", size: 10)
//
//        return v
//        
//        
//    }()
//    
//    lazy var topContentView: UIView = {
//        let topContentView = UIView()
//        topContentView.translatesAutoresizingMaskIntoConstraints = false
//        topContentView.layer.cornerRadius = 2
//        topContentView.backgroundColor = warmTreeTones.lightTertiary
//        
//        return topContentView
//    }()
//    
//    lazy var subContentView:UIView = {
//        let subContentView = UIView()
//        subContentView.translatesAutoresizingMaskIntoConstraints = false
//        subContentView.layer.cornerRadius = 2
//        subContentView.backgroundColor = warmClouds.darkPrimary
//        return subContentView
//    }()
//    
//    lazy var mainContentView: UIView = {
//        let mainContentView = UIView()
//         mainContentView.translatesAutoresizingMaskIntoConstraints = false
//         mainContentView.backgroundColor = UIColor.white
//         mainContentView.layer.shadowOffset = CGSize(width: 5, height: 5);
//         mainContentView.layer.shadowOpacity = 0.30;
//         mainContentView.layer.shadowRadius = 1.0;
//         mainContentView.layer.borderWidth = 1
//         mainContentView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
//         mainContentView.layer.cornerRadius = 2
//         return mainContentView
//        
//        
//    }()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    
//
//}
//
//extension MapViewCell{
//    private func setup(){
//        backgroundColor = UIColor.white
//        contentView.addSubview(mainContentView)
//        mainContentView.addSubview(topContentView)
//        mainContentView.addSubview(subContentView)
//        topContentView.addSubview(mapsNameLabel)
//        subContentView.addSubview(createdOnLabel)
//        subContentView.addSubview(countLabel)
//        setupMainConstraints()
//    }
//    
//    private func setupMainConstraints(){
//        NSLayoutConstraint.activate([
//            //MARK: main content view
//            mainContentView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 6),
//            mainContentView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -6),
//            mainContentView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 6),
//            mainContentView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -6),
//            
//            //MARK: maintop view
//            topContentView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 4),
//            topContentView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 4),
//            topContentView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -4),
//            
//            
//            // topContentView.bottomAnchor.constraint(lessThanOrEqualTo: topContentView.bottomAnchor, constant: -4),
//            //MARK: subcontent view
//            subContentView.topAnchor.constraint(equalTo: topContentView.bottomAnchor,constant: 2),
//            subContentView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 4),
//            subContentView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -4),
//            subContentView.bottomAnchor.constraint(lessThanOrEqualTo: mainContentView.bottomAnchor, constant: -4),// changed this
//            
//            //MARK: mapsnamelabel
//            mapsNameLabel.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 8),
//            mapsNameLabel.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor, constant:-8),
//            mapsNameLabel.topAnchor.constraint(equalTo: topContentView.topAnchor, constant: 8),
//            mapsNameLabel.bottomAnchor.constraint(equalTo: topContentView.bottomAnchor, constant: -8),
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
//            
//        ])
//        
//    }
//    
//
//    
//    func configure(with map: MapViewModel){
//        mapsNameLabel.text = map.title
//        
//        let fcAttrString = configureString(map: map, mapOrCreatedOn:  0)
//        countLabel.attributedText = fcAttrString
//        
//        let createdOnAttrString = configureString(map: map, mapOrCreatedOn: 1)
//        createdOnLabel.attributedText = createdOnAttrString
//
//        
//    }
//    
//    // which label are we configuring? createdOn(0) or flashcard count(1)
//    func configureString(map:MapViewModel, mapOrCreatedOn: Int)  -> NSMutableAttributedString{
//
//        let attrString = NSMutableAttributedString(string: "")
//        let attachment = NSTextAttachment()
//        let cardOrClock = mapOrCreatedOn == 0 ? "map" : "clock"
//        
//        if let image = UIImage(systemName: cardOrClock)?.withTintColor(UIColor.black){
//            attachment.image = image
//        }
//        
//        
//        attachment.bounds = mapOrCreatedOn == 0 ? CGRect(x: 0, y: -2, width: 15, height: 15) : CGRect(x: 0, y: -2, width: 15, height: 15)
//        attrString.append(NSAttributedString(attachment: attachment))
//        let mapOrCreatedOn = mapOrCreatedOn == 0 ? "\(map.mindMapCount)" : "\(map.createdOn.formatted(date: .abbreviated, time: .omitted))"
//        attrString.append(NSAttributedString(string: " \(mapOrCreatedOn)"))
//        
//        return attrString
//    }
//}
