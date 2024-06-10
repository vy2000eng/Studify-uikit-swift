//
//  FlashCard+CoreDataProperties.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/5/24.
//
//

import Foundation
import CoreData


extension FlashCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCard> {
        return NSFetchRequest<FlashCard>(entityName: "FlashCard")
    }

    @NSManaged public var back: String?
    @NSManaged public var front: String?
    @NSManaged public var id: UUID?
    @NSManaged public var subject: Subject?

}

extension FlashCard : Identifiable {

}
