//
//  Subject+CoreDataProperties.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/5/24.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var createdOn: Date?
    @NSManaged public var maps: NSSet?
    @NSManaged public var flashcards: FlashCard?

}

// MARK: Generated accessors for maps
extension Subject {

    @objc(addMapsObject:)
    @NSManaged public func addToMaps(_ value: MindMap)

    @objc(removeMapsObject:)
    @NSManaged public func removeFromMaps(_ value: MindMap)

    @objc(addMaps:)
    @NSManaged public func addToMaps(_ values: NSSet)

    @objc(removeMaps:)
    @NSManaged public func removeFromMaps(_ values: NSSet)

}

extension Subject : Identifiable {

}
