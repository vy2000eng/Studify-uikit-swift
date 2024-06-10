//
//  Topic+CoreDataProperties.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/5/24.
//
//

import Foundation
import CoreData


extension Topic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic> {
        return NSFetchRequest<Topic>(entityName: "Topic")
    }

    @NSManaged public var createdOn: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var topicTitle: String?
    @NSManaged public var flashcardset: [FlashCard]?
    @NSManaged public var subject: Subject?

}

extension Topic : Identifiable {

}
