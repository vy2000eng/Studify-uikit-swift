//
//  ThemeDmViewModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/4/24.
//

import Foundation
import UIKit


class ThemeDmViewModel{
    private var themeDM:ThemeDM
    
    init(themeDM: ThemeDM) {
        self.themeDM = themeDM
    }
        
    var id                  :UUID    { themeDM.themeId}
    var themeTitle          :String  {themeDM.themeTitle}
    
    var backgroundColor     :UIColor { themeDM.backgroundColor}
    var fontColor           :UIColor { themeDM.fontColor}
    var fontSecondaryColor  :UIColor { themeDM.fontSecondaryColor}
    
    var topicColor          :UIColor { themeDM.topicColor}
    var topSetColor         :UIColor { themeDM.topSetColor}
    var bottomSetColor      :UIColor { themeDM.bottomSetColor}
    var topListColor        :UIColor { themeDM.topListColor}
    var bottomListColor     :UIColor { themeDM.bottomListColor}
    


    


    
    

    
    
   
    
}
