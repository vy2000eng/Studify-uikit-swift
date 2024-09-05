//
//  AppThemeDM+CoreDataProperties.swift
//  Studify
//
//  Created by VladyslavYatsuta on 9/4/24.
//
//

import Foundation
import CoreData


extension AppThemeDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppThemeDM> {
        return NSFetchRequest<AppThemeDM>(entityName: "AppThemeDM")
    }

    @NSManaged public var themeTitle: String
    @NSManaged public var themeId: UUID
    @NSManaged public var themeDM: Set<ThemeDM>?

}

// MARK: Generated accessors for themeDM
extension AppThemeDM {

    @objc(addThemeDMObject:)
    @NSManaged public func addToThemeDM(_ value: ThemeDM)

    @objc(removeThemeDMObject:)
    @NSManaged public func removeFromThemeDM(_ value: ThemeDM)

    @objc(addThemeDM:)
    @NSManaged public func addToThemeDM(_ values: NSSet)

    @objc(removeThemeDM:)
    @NSManaged public func removeFromThemeDM(_ values: NSSet)

}

extension AppThemeDM : Identifiable {

}
