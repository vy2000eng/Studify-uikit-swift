//
//  SettingsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation
import UIKit


enum selectedRow{
    case one, two,three,four
}

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewmodel.title[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        switch(row){
        case 0:
            //viewmodel.setTheme(theme: AppTheme.superNova)
            //resetColor(theme: AppTheme.themeOne)
            resetColor(theme: AppTheme.superNova)
            break
            
        case 1:
            resetColor(theme: AppTheme.thunderStorm)
            break
        case 2:
            resetColor(theme: AppTheme.stormySea)
            break
            

           // viewmodel.setTheme(theme: AppTheme.thunderStorm)
//        case 1:
//            //viewmodel.setTheme(theme: AppTheme.oceanSand)
//            resetColor(theme: AppTheme.oceanSand)
//
//            break
//        case 2:
//            //viewmodel.setTheme(theme: AppTheme.warmClouds)
//            resetColor(theme: AppTheme.warmClouds)
//
//            break
//        case 3:
//           // viewmodel.setTheme(theme: AppTheme.warmTreeTones)
//            resetColor(theme: AppTheme.warmTreeTones)
//            break
//        case 4:
//            resetColor(theme: AppTheme.mildWinter)
//            break
//        case 5:
//            resetColor(theme: AppTheme.royalty)
//            break
//            
        default:
            fatalError("couldn't select a color")
        }
        
    }

    
    
    let viewmodel = SettingsViewModel()
    
   
    lazy var vstack: UIStackView = {
       let vstack = UIStackView()
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.axis = .vertical
        vstack.spacing = 10
        vstack.distribution = .fillEqually
        return vstack
    }()
    
    lazy var subjectlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var topiclabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var maplabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
 
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
        return label
        
    }()
    lazy var bottomSetlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    

    
    lazy var listVstack:UIStackView = {
        var listStackView = UIStackView()
        listStackView.translatesAutoresizingMaskIntoConstraints = false
        listStackView.axis = .vertical
        listStackView.distribution = .fillEqually
        return listStackView
    }()
    
    
//    lazy var listlabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//        
//    }()
    lazy var topListlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    lazy var bottomListlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()

    lazy var colorPicker:UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        return picker
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTheme))
        setup()
    }
    
    
    
    
    
}

struct ColorItem{
    let label: UILabel
    let color: UIColor
    let title: String

}
extension SettingsViewController{
    private func setup(){
        view.backgroundColor = viewmodel.backgroundColor
        view.addSubview(vstack)
        

        vstack.addArrangedSubview(colorPicker)
        vstack.addArrangedSubview(subjectlabel)
        vstack.addArrangedSubview(topiclabel)
        vstack.addArrangedSubview(maplabel)
        vstack.addArrangedSubview(setVstack)
        vstack.addArrangedSubview(listVstack)
        
//        setlabel.addSubview(topSetlabel)
//        setlabel.addSubview(bottomSetlabel)
//        listlabel.addSubview(topListlabel)
//        listlabel.addSubview(bottomListlabel)
        
        setVstack.addArrangedSubview(topSetlabel)
        setVstack.addArrangedSubview(bottomSetlabel)
        
        listVstack.addArrangedSubview(topListlabel)
        listVstack.addArrangedSubview(bottomListlabel)
        
        
        
        
        colorPicker.selectRow(viewmodel.currentTheme.rawValue, inComponent: 0, animated: false)
        
        subjectlabel.backgroundColor = viewmodel.subjectColor
        topiclabel.backgroundColor = viewmodel.topicColor
        maplabel.backgroundColor = viewmodel.mapColor
        
        topSetlabel.backgroundColor = viewmodel.setTopColor
        bottomSetlabel.backgroundColor = viewmodel.setBottomColor
        
        topListlabel.backgroundColor = viewmodel.listTopColor
        bottomListlabel.backgroundColor = viewmodel.listBottomColor
        
        
        subjectlabel.text = "Subject"
        subjectlabel.textColor = viewmodel.fontColor
        
        topiclabel.text = "Topic"
        topiclabel.textColor = viewmodel.fontColor
        
        maplabel.text = "map"
        maplabel.textColor = viewmodel.fontColor
        
        topSetlabel.text = "Top Set"
        topSetlabel.textColor = viewmodel.fontColor
        
        bottomSetlabel.text = "Bottom Set"
        bottomSetlabel.textColor = viewmodel.fontColor
        
        topListlabel.text = "Top List"
        topListlabel.textColor = viewmodel.fontColor
        
        bottomListlabel.text = "Bottom List"
        bottomListlabel.textColor = viewmodel.fontColor

        setupConstraints()

    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            vstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vstack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vstack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vstack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            

            
        ])
        
        
    }
    @objc
    private func saveTheme(){
        
        if let theme = AppTheme(rawValue:  colorPicker.selectedRow(inComponent: 0)) {
            ColorManager.shared.setTheme(theme:theme)
           // viewmodel.selectedRow =
            //resetColor(theme: viewmodel.currentTheme)
            navigationController?.popViewController(animated: true)
            //resetColor()
        }
        
    }
    
    func resetColor(theme: AppTheme){
        //        let labelArr = [ColorItem(label: subjectlabel, color: theme.colors.subjectColor, title: "Subject"),
        //                        ColorItem(label: topiclabel, color: theme.colors.topicColor, title: "Topic"),
        //                        ColorItem(label: maplabel, color:theme.colors.mapColor, title: "Map"),
        //                        ColorItem(label: setlabel, color: theme.colors.setColor, title: "Set"),
        //                        ColorItem(label: listlabel, color: theme.colors.listColor, title: "List")]
        //
        //        for label in labelArr{
        //            label.label.backgroundColor = label.color
        //
        view.backgroundColor = viewmodel.backgroundColor

        
        subjectlabel.backgroundColor =           theme.colors.subjectColor
        topiclabel.backgroundColor =             theme.colors.topicColor
        maplabel.backgroundColor =               theme.colors.mapColor
       
        topSetlabel.backgroundColor =            theme.colors.topColor
        bottomSetlabel.backgroundColor =         theme.colors.bottomColor
       
        topListlabel.backgroundColor =           theme.colors.topColor
        bottomListlabel.backgroundColor =        theme.colors.bottomColor
        
        
        //subjectlabel.text = "Subject"
        subjectlabel.textColor =                    theme.colors.fontColor
        
       // topiclabel.text = "Topic"
        topiclabel.textColor =                      theme.colors.fontColor
        
        maplabel.textColor = theme.colors.fontColor
        
        //topSetlabel.text = "Top Set"
        topSetlabel.textColor =                     theme.colors.fontColor
        
        //bottomSetlabel.text = "Bottom Set"
        bottomSetlabel.textColor =                   theme.colors.fontColor
        
        //topListlabel.text = "Top List"
        topListlabel.textColor =                     theme.colors.fontColor
        
        //bottomListlabel.text = "Bottom List"
        bottomListlabel.textColor =                 theme.colors.fontColor
        
        
    }
    
    
    
    
}
    

