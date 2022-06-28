//
//  Author+CoreDataProperties.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: "Author")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?

}

extension Author : Identifiable {

}
