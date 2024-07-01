//
//  Topic+CoreDataProperties.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/22/24.
//
//

import Foundation
import CoreData


extension Topic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic> {
        return NSFetchRequest<Topic>(entityName: "Topic")
    }

    @NSManaged public var createdOn: Date
    @NSManaged public var id: UUID
    @NSManaged public var topicTitle: String
    @NSManaged public var flashcardset: Set<FlashCard>?
    @NSManaged public var subject: Subject?

}

// MARK: Generated accessors for flashcardset
extension Topic {

    @objc(addFlashcardsetObject:)
    @NSManaged public func addToFlashcardset(_ value: FlashCard)

    @objc(removeFlashcardsetObject:)
    @NSManaged public func removeFromFlashcardset(_ value: FlashCard)

    @objc(addFlashcardset:)
    @NSManaged public func addToFlashcardset(_ values: NSSet)

    @objc(removeFlashcardset:)
    @NSManaged public func removeFromFlashcardset(_ values: NSSet)

}

extension Topic : Identifiable {

}
