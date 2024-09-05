//
//  SettingsColorPickerController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/17/24.
//

import UIKit

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? viewmodel.themeCount : viewmodel.fontCount
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attr :[NSAttributedString.Key: Any] = [.foregroundColor: viewmodel.isIntermediaryThemeDark ? UIColor.white : UIColor.black ]
        return component == 0 
        ? NSAttributedString( string: viewmodel.appDmTheme(by: row),attributes: attr)
        : NSAttributedString( string: viewmodel.fontTitle[row],attributes: attr)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            switch(row){
            case 0:
                currentTheme = AppTheme.superNova
                break
            case 1:
                currentTheme = AppTheme.darkPastel
                break
            case 2:
                currentTheme = AppTheme.stormySea
                break
            case 3:
                currentTheme = AppTheme.cloudySunset
                break
            default:
                fatalError("couldn't select a color")
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else{
                    return
                }
                resetColor(theme: currentTheme)
            }
        }else{
            switch(row){
            case 0:
                currentFont = .Avenir
                break;
            case 1:
                currentFont = .BaskerVille
                break;
            case 2:
                currentFont = .Georgia
                break;
            case 3:
                currentFont = .Helvetica
                break;
            case 4:
                currentFont = .Verdana
                break;
            case 5:
                currentFont = .GillSans
                break
            case 6:
                currentFont = .Optima
                break;
            case 7:
                currentFont = .AmericanTypeWriter
                break;
            case 8:
                currentFont = .AppleSdGothicNeo
                break;
            case 9:
                currentFont = .Damascus
                break;
            default:
                fatalError("couldn't select a color")
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else{
                    return
                }
                resetFont(themeFont: currentFont)
            }
        }
    }
}

extension SettingsViewController{
    private func resetFont(themeFont: themeFont){

        for (index, label)in labels.enumerated(){
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            
            let attributedString = NSMutableAttributedString()
            
            // Add the title
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: themeFont.font.font(style: .bold, size: 17),
                .foregroundColor: currentTheme.colors.fontColor
            ]
            attributedString.append(NSAttributedString(string: viewmodel.cellTitle[index] + "\n", attributes: titleAttributes))
            
            // Add some additional text (you can customize this part)
            let detailAttributes: [NSAttributedString.Key: Any] = [
                .font: themeFont.font.font(style: .semiBold, size: 14),
                .foregroundColor: currentTheme.colors.fontColorSecondary
            ]
            attributedString.append(NSAttributedString(string: "Card details", attributes: detailAttributes))
            
            // Set the attributed text to the label
            UIView.transition(with: settingCardView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                label.attributedText = attributedString
            }, completion: nil)
        }
    }
    func resetColor(theme: AppTheme){
        
        if theme.colors.backGroundColor != view.backgroundColor{
            UIView.transition(with: settingCardView, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
                guard let self = self else{
                    return
                }
                settingCardView.colorPicker.reloadComponent(0)
                settingCardView.colorPicker.reloadComponent(1)
                settingCardView.colorPicker.backgroundColor = theme.colors.backGroundColor
                view.backgroundColor = theme.colors.backGroundColor
                
            }, completion: nil)
            setupTitle(theme: theme)
            
        }
        viewmodel.isIntermediaryThemeDark = theme.colors.backGroundColor == .black ? true: false

        let labels = [
            //settingCardView.subjectlabel :  theme.colors.subjectColor ,
                      settingCardView.topiclabel: theme.colors.topicColor,
                     // settingCardView.maplabel: theme.colors.mapColor,
                      settingCardView.topSetlabel: theme.colors.topColor,
                      settingCardView.bottomSetlabel: theme.colors.bottomColor,
                      settingCardView.topListlabel: theme.colors.topColor,
                      settingCardView.bottomListlabel:  theme.colors.bottomColor]
        
        for (label, color) in labels{
            UIView.transition(with: settingCardView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                label.backgroundColor = color
                label.textColor = theme.colors.fontColor
            }, completion: nil)
            
        }
    }
}
        

        
     
 
