//
//  Subject+CoreDataProperties.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/1/24.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var createdOn: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var addedFirst: Int16
    @NSManaged public var maps: Set<Maps>?
    @NSManaged public var topics: Set<Topic>?

}

// MARK: Generated accessors for maps
extension Subject {

    @objc(addMapsObject:)
    @NSManaged public func addToMaps(_ value: Maps)

    @objc(removeMapsObject:)
    @NSManaged public func removeFromMaps(_ value: Maps)

    @objc(addMaps:)
    @NSManaged public func addToMaps(_ values: NSSet)

    @objc(removeMaps:)
    @NSManaged public func removeFromMaps(_ values: NSSet)

}

// MARK: Generated accessors for topics
extension Subject {

    @objc(addTopicsObject:)
    @NSManaged public func addToTopics(_ value: Topic)

    @objc(removeTopicsObject:)
    @NSManaged public func removeFromTopics(_ value: Topic)

    @objc(addTopics:)
    @NSManaged public func addToTopics(_ values: NSSet)

    @objc(removeTopics:)
    @NSManaged public func removeFromTopics(_ values: NSSet)

}

extension Subject : Identifiable {

}
