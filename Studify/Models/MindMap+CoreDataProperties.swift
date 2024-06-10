//
//  MindMap+CoreDataProperties.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/5/24.
//
//

import Foundation
import CoreData


extension MindMap {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MindMap> {
        return NSFetchRequest<MindMap>(entityName: "MindMap")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var subject: Subject?

}

extension MindMap : Identifiable {

}
