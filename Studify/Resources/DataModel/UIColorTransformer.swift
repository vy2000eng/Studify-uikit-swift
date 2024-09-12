//
//  UIColorTransformer.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/8/24.
//

import Foundation
import UIKit

class UIColorTransformer:ValueTransformer{
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else{return nil}
        
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)

            return data
        }catch let error as NSError{
            NSLog("Error transforming Value from UIColor to Data: %@ : %@", error.userInfo, error.localizedDescription)
                return nil
        }
        
        
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else{return nil}
        
        do{
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)

            return color
        }catch let error as NSError{
            NSLog("Error transforming Value from UIColor to Data: %@ : %@", error.userInfo, error.localizedDescription)
                return nil
        }
        
    }
    
    
}
