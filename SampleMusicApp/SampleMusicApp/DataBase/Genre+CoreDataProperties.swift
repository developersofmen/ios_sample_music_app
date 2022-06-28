//
//  Genre+CoreDataProperties.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//
//

import Foundation
import CoreData


extension Genre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged public var genreId: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?

}

extension Genre : Identifiable {

}
