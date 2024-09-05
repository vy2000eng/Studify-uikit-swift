//
//  AppThemeCoreDataManager.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/4/24.
//

import Foundation
import CoreData

extension CoreDataManager{
    
    func addNewTheme(title:String){
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
            NSLog("Error fetching all themes: %@ : %@", error.userInfo, error.localizedDescription)
            return []
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
