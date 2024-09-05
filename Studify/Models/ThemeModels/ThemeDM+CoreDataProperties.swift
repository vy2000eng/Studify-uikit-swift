//
//  ThemeDM+CoreDataProperties.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/4/24.
//
//

import Foundation
import CoreData


extension ThemeDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThemeDM> {
        return NSFetchRequest<ThemeDM>(entityName: "ThemeDM")
    }

    @NSManaged public var themeId: UUID
    @NSManaged public var topicColor: String
    @NSManaged public var backgroundColor: String
    @NSManaged public var fontSecondaryColor: String
    @NSManaged public var fontColor: String
    @NSManaged public var bottomColor: String
    @NSManaged public var topColor: String
    @NSManaged public var appDM: AppThemeDM?

}

extension ThemeDM : Identifiable {

}
