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
        6
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewmodel.title[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        switch(row){
        case 0:
            //viewmodel.setTheme(theme: AppTheme.themeOne)
            resetColor(theme: AppTheme.themeOne)
            
            break
        case 1:
            //viewmodel.setTheme(theme: AppTheme.oceanSand)
            resetColor(theme: AppTheme.oceanSand)

            break
        case 2:
            //viewmodel.setTheme(theme: AppTheme.warmClouds)
            resetColor(theme: AppTheme.warmClouds)

            break
        case 3:
           // viewmodel.setTheme(theme: AppTheme.warmTreeTones)
            resetColor(theme: AppTheme.warmTreeTones)
            break
        case 4:
            resetColor(theme: AppTheme.mildWinter)
            break
        case 5:
            resetColor(theme: AppTheme.royalty)
            break
            
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
 
    lazy var setlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var listlabel: UILabel = {
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
        view.addSubview(vstack)
//        
//        let labelArr = [ColorItem]()
//        labelArr.map(ColorItem.init(label: <#T##UILabel#>, color: <#T##UIColor#>, title: <#T##String#>))

        let labelArr = [ColorItem(label: subjectlabel, color: viewmodel.subjectColor, title: "Subject"),
                        ColorItem(label: topiclabel, color: viewmodel.topicColor, title: "Topic"),
                        ColorItem(label: maplabel, color: viewmodel.mapColor, title: "Map"),
                        ColorItem(label: setlabel, color: viewmodel.setColor, title: "Set"),
                        ColorItem(label: listlabel, color: viewmodel.listColor, title: "List"),
        ]
        
        vstack.addArrangedSubview(colorPicker)
        colorPicker.selectRow(viewmodel.currentTheme.rawValue, inComponent: 0, animated: false)
        for label in labelArr{
            vstack.addArrangedSubview(label.label)
            label.label.backgroundColor = label.color
            label.label.text = label.title
            
        }
        setupConstraints()
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            vstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vstack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vstack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vstack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)


        
        
        ])
        
        
    }
    @objc
    private func saveTheme(){
       
        if let theme = AppTheme(rawValue:  colorPicker.selectedRow(inComponent: 0)) {
            ColorManager.shared.setTheme(theme:theme)
            resetColor(theme: viewmodel.currentTheme)
            navigationController?.popViewController(animated: true)
            //resetColor()
        }
        
    }
    
    func resetColor(theme: AppTheme){
        let labelArr = [ColorItem(label: subjectlabel, color: theme.colors.subjectColor, title: "Subject"),
                        ColorItem(label: topiclabel, color: theme.colors.topicColor, title: "Topic"),
                        ColorItem(label: maplabel, color:theme.colors.mapColor, title: "Map"),
                        ColorItem(label: setlabel, color: theme.colors.setColor, title: "Set"),
                        ColorItem(label: listlabel, color: theme.colors.listColor, title: "List")]
      
        for label in labelArr{
            label.label.backgroundColor = label.color
            
        }
                        
       
       
    }
    
}
