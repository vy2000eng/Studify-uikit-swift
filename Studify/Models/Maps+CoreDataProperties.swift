//
//  Maps+CoreDataProperties.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/6/24.
//
//

import Foundation
import CoreData


extension Maps {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Maps> {
        return NSFetchRequest<Maps>(entityName: "Maps")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var createdOn: Date?
    @NSManaged public var subject: Subject?
    @NSManaged public var mapSet: [MindMap]?

}

extension Maps : Identifiable {

}
