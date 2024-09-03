//
//  SettingsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/6/24.
//

import Foundation
import UIKit


class SettingsViewController: UIViewController{
    
    var currentTheme = ColorManager.shared.currentTheme
    var currentFont = FontManager.shared.currentThemeFont
    let viewmodel = SettingsViewModel()
    let settingCardView :SettingsCardsView
    let labels: [UILabel]
    
    init() {
        
        settingCardView = SettingsCardsView(settingViewmodel: viewmodel, frame: .zero)
        
        labels = [settingCardView.subjectlabel,
                  settingCardView.topiclabel,
                  settingCardView.maplabel,
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
        
        
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTheme))
        setup()
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
        setupConstraints()
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
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            settingCardView.topAnchor.constraint(equalTo: view.topAnchor),
            settingCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
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
    

