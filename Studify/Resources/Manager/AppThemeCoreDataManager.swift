//
//  AppThemeCoreDataManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/4/24.
//

import Foundation
import CoreData
import UIKit

extension CoreDataManager{
    
    func addNewAppThemeDM(title:String){
        let newAppThemeDM = AppThemeDM(context: context)
        newAppThemeDM.themeId = UUID()
        newAppThemeDM.themeTitle = title
        do{
            try context.save()
            
        }catch let error as NSError{
            print("Error adding theme: \(error.userInfo), \(error.localizedDescription)")
   
        }
    }
    
    func getAllAppThemes()->[AppThemeDM]{
        let fetchRequest:NSFetchRequest<AppThemeDM> = AppThemeDM.fetchRequest()
        do{
            let themes = try context.fetch(fetchRequest)
            return themes
            
        }catch let error as NSError{
            NSLog("Error fetching all AppThemeDM: %@ : %@", error.userInfo, error.localizedDescription)
            return []
        }
    }
    
    func getAllThemeDMForAppThemeDm(appThemeDmId:UUID)->[ThemeDM]{
        let fetchRequest:NSFetchRequest<ThemeDM> = ThemeDM.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", appThemeDmId as CVarArg)
        do {
            return try context.fetch(fetchRequest)
            
            
        }catch let error as NSError{
            NSLog("Error fetching all ThemeDM: %@ : %@", error.userInfo, error.localizedDescription)
            return []
        }
    }
    
    func insertThemeDMIntoAppThemeDM(theme:Theme,appThemeDMId:UUID){
        let fetchRequest:NSFetchRequest<AppThemeDM> = AppThemeDM.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", appThemeDMId.uuidString)
        
        let newThemeDM = ThemeDM(context: context)
        newThemeDM.backgroundColor = theme.backGroundColor
        newThemeDM.bottomSetColor =  theme.bottomColor
        newThemeDM.fontColor = theme.fontColor
        newThemeDM.fontSecondaryColor = theme.fontColorSecondary
        newThemeDM.themeId = UUID()
        newThemeDM.topSetColor = theme.topColor
        newThemeDM.topicColor = theme.topicColor
        newThemeDM.bottomListColor = theme.bottomColor
        newThemeDM.topListColor = theme.topColor
        
        do{
            let appThemeDm = try context.fetch(fetchRequest).first
            appThemeDm?.addToThemeDM(newThemeDM)
            try context.save()
            
        }catch let error as NSError{
            NSLog("Error inserting theme: %@ : %@", error.userInfo, error.localizedDescription)

        }

        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
