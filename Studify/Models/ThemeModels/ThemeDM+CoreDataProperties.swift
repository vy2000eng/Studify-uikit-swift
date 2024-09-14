//
//  ThemeDM+CoreDataProperties.swift
//  Studify
//
//  Created by Vladyslav Yatsuta on 9/13/24.
//
//

import Foundation
import CoreData
import UIKit


extension ThemeDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThemeDM> {
        return NSFetchRequest<ThemeDM>(entityName: "ThemeDM")
    }

    @NSManaged public var backgroundColor: UIColor
    @NSManaged public var bottomListColor: UIColor
    @NSManaged public var bottomSetColor: UIColor
    @NSManaged public var fontColor: UIColor
    @NSManaged public var fontSecondaryColor: UIColor
    @NSManaged public var themeId: UUID
    @NSManaged public var topicColor: UIColor
    @NSManaged public var topListColor: UIColor
    @NSManaged public var topSetColor: UIColor
    @NSManaged public var themeTitle: String

}

extension ThemeDM : Identifiable {

}
