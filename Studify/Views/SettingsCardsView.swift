//
//  SettingsCardsView.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/15/24.
//

import Foundation
import UIKit



class SettingsCardsView:UIView{
    
    
    lazy var vstack: UIStackView = {
        let vstack = UIStackView()
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.axis = .vertical
        vstack.spacing = 10
        vstack.distribution = .fillEqually
        return vstack
    }()
    
    
    
//    lazy var subjectlabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//        
//    }()
    
    //let subjectViewCell = SubejctListViewCell()
    //let subjectviewmodel = SubjectViewModel(subject: <#T##Subject#>)
    
    
    lazy var topiclabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.isUserInteractionEnabled = true
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
//        label.addGestureRecognizer(longPress)
        return label
        
    }()
    
//    lazy var maplabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//        
//    }()
    
    lazy var setVstack: UIStackView = {
        let setStackView = UIStackView()
        setStackView.translatesAutoresizingMaskIntoConstraints = false
        setStackView.axis = .vertical
        setStackView.distribution = .fillEqually
        
        return setStackView
    }()
    
    lazy var topSetlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.isUserInteractionEnabled = true
        return label
        
    }()
    lazy var bottomSetlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.isUserInteractionEnabled = true
        return label
        
    }()
    
    
    
    lazy var listVstack:UIStackView = {
        var listStackView = UIStackView()
        listStackView.translatesAutoresizingMaskIntoConstraints = false
        listStackView.axis = .vertical
        listStackView.distribution = .fillEqually
        return listStackView
    }()
    
    
    lazy var topListlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.isUserInteractionEnabled = true
        return label
        
    }()
    lazy var bottomListlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.isUserInteractionEnabled = true
        return label
        
    }()
    lazy var colorPicker:UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
        
    }()
    
    let settingViewmodel:SettingsViewModel
    
    init(settingViewmodel:SettingsViewModel, frame: CGRect){
        self.settingViewmodel = settingViewmodel
        super.init(frame: frame)
        setup()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SettingsCardsView{
    private func setup(){
        backgroundColor = .clear
        
        
        
        
        addSubview(vstack)
        
        
        vstack.addArrangedSubview(colorPicker)
        //vstack.addArrangedSubview(subjectlabel)
        vstack.addArrangedSubview(topiclabel)
        //vstack.addArrangedSubview(maplabel)
        vstack.addArrangedSubview(setVstack)
        vstack.addArrangedSubview(listVstack)
        
        
        setVstack.addArrangedSubview(topSetlabel)
        setVstack.addArrangedSubview(bottomSetlabel)
        
        listVstack.addArrangedSubview(topListlabel)
        listVstack.addArrangedSubview(bottomListlabel)
        
        let labelArray: [(UILabel, UIColor)] = [
           // (subjectlabel, settingViewmodel.subjectColor),
            (topiclabel, settingViewmodel.topicColor),
          //  (maplabel, settingViewmodel.mapColor),
            (topSetlabel, settingViewmodel.topColor),
            (bottomSetlabel, settingViewmodel.bottomColor),
            (topListlabel, settingViewmodel.topColor),
            (bottomListlabel, settingViewmodel.bottomColor)
        ]
        
        for (index, (label,color)) in labelArray.enumerated(){
            print("index: \(index)")
            label.backgroundColor = color
            
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
                
            let attributedString = NSMutableAttributedString()
            
            // Add the title
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: settingViewmodel.primaryFont,
                .foregroundColor: settingViewmodel.fontColor
            ]
            attributedString.append(NSAttributedString(string: settingViewmodel.cellTitle[index] + "\n", attributes: titleAttributes))
            
            // Add some additional text (you can customize this part)
            let detailAttributes: [NSAttributedString.Key: Any] = [
                .font: settingViewmodel.secondaryFont,
                .foregroundColor: settingViewmodel.fontColor
            ]
            attributedString.append(NSAttributedString(string: "Card details", attributes: detailAttributes))
            
            // Set the attributed text to the label
            label.attributedText = attributedString
            
     
            
            print("cell title:\(settingViewmodel.cellTitle[index])")
            
        }
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            vstack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            vstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vstack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
        ])
        
        
    }
    
}




extension SettingsCardsView{
    enum settingSection{
        case topic
        case topSet
        case bottomSet
        case topList
        case bottomList
    }
    
    
//    @objc
//    func handleLongPress(gesture: UILongPressGestureRecognizer){
//        if gesture.state == .began{
//            NSLog("gesture tapped")
//            
//        }
//        
//    }
}
