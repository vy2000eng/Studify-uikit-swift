//
//  SettingsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation
import UIKit


class SettingsViewController: UIViewController, UIColorPickerViewControllerDelegate{
    
    var currentTheme = ColorManager.shared.currentTheme
    var currentFont = FontManager.shared.currentThemeFont
    let viewmodel = SettingsViewModel()
    let settingCardView :SettingsCardsView
    let labels: [UILabel]
    private var optionsMenu: UIMenu?
    private var viewID:Int?

    
    init() {
        
        settingCardView = SettingsCardsView(settingViewmodel: viewmodel, frame: .zero)
        
        labels = [
            //settingCardView.subjectlabel,
                  settingCardView.topiclabel,
                //  settingCardView.maplabel,
                  settingCardView.topSetlabel,
                  settingCardView.bottomSetlabel,
                  settingCardView.topListlabel,
                  settingCardView.bottomListlabel]
        
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // title = "Settings"
        
        
        //navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTheme))
        navigationItem.rightBarButtonItem = createOptionsBarButtonItem()
        setup()
        setupConstraints()
        setupLongPress()


    }
}
extension SettingsViewController{
    

    
    private func setup(){
        view.backgroundColor =  currentTheme.colors.backGroundColor
        
        setupTitle(theme: viewmodel.currentTheme)
        
        
        settingCardView.colorPicker.delegate = self
        settingCardView.colorPicker.dataSource = self
        settingCardView.translatesAutoresizingMaskIntoConstraints = false
        settingCardView.colorPicker.selectRow(viewmodel.currentTheme.rawValue, inComponent: 0, animated: false)
        settingCardView.colorPicker.selectRow(viewmodel.currentFontTheme.rawValue, inComponent: 1, animated: false)
        
        view.addSubview(settingCardView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            settingCardView.topAnchor.constraint(equalTo: view.topAnchor),
            settingCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    private func setupLongPress(){

     //   settingCardView.topiclabel.addGestureRecognizer(longPress)
        for (index, label) in labels.enumerated(){
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(longPress)
            label.tag = index
            
        }
        
    }
    
    func setupTitle(theme: AppTheme){
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.prefersLargeTitles = true // If you want a standard size title
            navigationBar.largeTitleTextAttributes = [
                .foregroundColor: theme.colors.fontColor,
                .font: theme.colors.primaryFont
            ]
        
            // Force refresh of the navigation item
            navigationItem.title = nil
            navigationItem.title = "Settings"
        }
        
    }
    

    
    
    private func createOptionsBarButtonItem()-> UIBarButtonItem{
        let addThemeAction = UIAction(title: "new theme 🎨"){ [weak self] _ in
            guard let self = self else{return}
            addNewTheme()
            
            
            
        }
        let saveThemeAction = UIAction(title: "save theme 💾"){ [weak self] _ in
            guard let self = self else{return}
            saveTheme()
            
            
        }
        optionsMenu = UIMenu(title: "options", children: [saveThemeAction, addThemeAction])
        return UIBarButtonItem(image: UIImage(systemName: "ellipsis"), menu: optionsMenu)
        
    }
    


}
    
extension SettingsViewController{
    @objc
    private func addNewTheme(){
        currentTheme = .defaultTheme
       // viewmodel.themeTitle.append("New Theme")
        
        resetColor(theme: currentTheme)
        
        
    }
    
    @objc
    private func saveTheme(){

        let alert = UIAlertController(
            title: "Confirmation",
            message: "Are you sure you want to apply these changes?",
            preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .destructive,
                handler: {[weak self] UIAlertAction in
                    guard let self = self else {
                        return
                    }
                    dismiss(animated: true)
                }
            ))
        alert.addAction(
            UIAlertAction(
                title: "Apply Theme",
                style: .default,
                handler: {[weak self] UIAlertAction in
                    
                    guard let self = self else {
                        return
                    }
                    
                    if let fontTheme = themeFont(rawValue:  settingCardView.colorPicker.selectedRow(inComponent: 1)){
                        viewmodel.setFontTheme(themeFont: fontTheme)
                    }
                    if let theme = AppTheme(rawValue: settingCardView.colorPicker.selectedRow(inComponent: 0)) {
                        viewmodel.setTheme(theme: theme)
                        
                    }
                    navigationController?.popViewController(animated: true)
                }
                
            ))
        present(alert, animated: true)
    }
    
    
}

extension SettingsViewController{
    @objc
    func handleLongPress(gesture: UILongPressGestureRecognizer){
        if gesture.state == .began{
            viewID = gesture.view?.tag
            
            guard let id = viewID, id >= 0, id <= 4 else {
                fatalError("Developer Error: viewID is nil or out of range (1-4)")
            }
            
            
            print("long press tapped")
            let colorPickerVC = UIColorPickerViewController()
            colorPickerVC.delegate = self
            present(colorPickerVC,animated: true)
            
            
        }
        
    }
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        guard let id = viewID, id >= 0, id <= 4 else {
            fatalError("Developer Error: viewID is nil or out of range (1-4)")
        }
        
        print(id)
        switch id{
        case 0:
            settingCardView.topiclabel.backgroundColor = color
            break
        case 1:
            settingCardView.topSetlabel.backgroundColor = color
            
            break
        case 2:
            settingCardView.bottomSetlabel.backgroundColor = color
            
            break
        case 3:
            settingCardView.topListlabel.backgroundColor = color
            
            break
        case 4:
            settingCardView.bottomListlabel.backgroundColor = color
            
            break
            
        default:
            break
            
        }
    }
}
    
