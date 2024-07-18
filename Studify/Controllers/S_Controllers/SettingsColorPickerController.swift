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
        return component == 0 ? 4 : 10
    }


    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attr :[NSAttributedString.Key: Any] = [.foregroundColor: viewmodel.isIntermediaryThemeDark ? UIColor.white : UIColor.black ]
       
         return component == 0 ?
         NSAttributedString( string: viewmodel.themeTitle[row],attributes: attr) :
         NSAttributedString( string: viewmodel.fontTitle[row],attributes: attr)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            switch(row){
            case 0:
                DispatchQueue.main.async {
                  
                    
                    UIView.animate(withDuration: 0.5){ [weak self] in
                        guard let self = self else{
                            return
                        }
                        currentTheme = AppTheme.superNova
                        resetColor(theme: currentTheme)
                        
                    }
                }
//                currentTheme = AppTheme.superNova
//                resetColor(theme: currentTheme)
               // pickerView.backgroundColor = AppTheme.superNova.colors.backGroundColor
                break
                
            case 1:
                currentTheme = AppTheme.darkPastel
                resetColor(theme: currentTheme)
                //pickerView.backgroundColor = AppTheme.darkPastel.colors.backGroundColor
                
                break
                
            case 2:
                currentTheme = AppTheme.stormySea
                resetColor(theme: currentTheme)
               // pickerView.backgroundColor = AppTheme.stormySea.colors.backGroundColor
                
                break
                
            case 3:
                currentTheme = AppTheme.cloudySunset
                resetColor(theme: currentTheme)
                //pickerView.backgroundColor = AppTheme.cloudySunset.colors.backGroundColor
                break
                
                
            default:
                fatalError("couldn't select a color")
            }
            
            
        }else{
            switch(row){
            case 0:
                
                resetFont(themeFont: .Avenir)
                break;
            case 1:
                
                resetFont(themeFont: .BaskerVille)
                break;
            case 2:
                
                resetFont(themeFont: .Georgia)
                break;
            case 3:
                
                resetFont(themeFont: .Helvetica)
                break;
            case 4:
                
                resetFont(themeFont: .Verdana)
                break;
            case 5:
                
                resetFont(themeFont: .GillSans)
                break
            case 6:
                
                resetFont(themeFont: .Optima)
                break;
            case 7:
                
                resetFont(themeFont: .AmericanTypeWriter)
                break;
            case 8:
                
                resetFont(themeFont: .AppleSdGothicNeo)
                break;
            case 9:
                
                resetFont(themeFont: .Damascus)
                break;
            default:
                fatalError("couldn't select a color")
                
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
                .foregroundColor: viewmodel.fontColor
            ]
            attributedString.append(NSAttributedString(string: viewmodel.cellTitle[index] + "\n", attributes: titleAttributes))
            
            // Add some additional text (you can customize this part)
            let detailAttributes: [NSAttributedString.Key: Any] = [
                .font: themeFont.font.font(style: .semiBold, size: 14),
                .foregroundColor: viewmodel.fontColor
            ]
            attributedString.append(NSAttributedString(string: "Card details", attributes: detailAttributes))
            
            // Set the attributed text to the label
            label.attributedText = attributedString
            
        }
    }
    private func resetColor(theme: AppTheme){
        
        if theme.colors.backGroundColor != view.backgroundColor{
            
            print("comp reloaded")
            settingCardView.colorPicker.reloadComponent(0)
            settingCardView.colorPicker.reloadComponent(1)
            settingCardView.colorPicker.backgroundColor = theme.colors.backGroundColor
         //   settingCardView.backgroundColor = theme.colors.backGroundColor
            view.backgroundColor = theme.colors.backGroundColor
            
            setupTitle(theme: theme)
                        
        }
        viewmodel.isIntermediaryThemeDark = theme.colors.backGroundColor == .black ? true: false
   
        
        let labels = [settingCardView.subjectlabel :  theme.colors.subjectColor ,
                      settingCardView.topiclabel: theme.colors.topicColor,
                      settingCardView.maplabel: theme.colors.mapColor,
                      settingCardView.topSetlabel: theme.colors.topColor,
                      settingCardView.bottomSetlabel: theme.colors.bottomColor,
                      settingCardView.topListlabel: theme.colors.topColor,
                      settingCardView.bottomListlabel:  theme.colors.bottomColor]
        
        
        for (label, color) in labels{
            
            label.backgroundColor = color
            label.textColor = theme.colors.fontColor
        }
    }
}
        

        
     
 
