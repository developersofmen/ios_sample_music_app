//
//  Result+CoreDataProperties.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//
//

import Foundation
import CoreData


extension Result {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
        return NSFetchRequest<Result>(entityName: "Result")
    }

    @NSManaged public var artistId: String?
    @NSManaged public var artistName: String?
    @NSManaged public var artistUrl: String?
    @NSManaged public var artworkUrl100: String?
    @NSManaged public var contentAdvisoryRating: String?
    @NSManaged public var id: String?
    @NSManaged public var kind: String?
    @NSManaged public var name: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var url: String?
    @NSManaged public var toFeed: Album?
    @NSManaged public var toGenre: NSSet?

}

// MARK: Generated accessors for toGenre
extension Result {

    @objc(addToGenreObject:)
    @NSManaged public func addToToGenre(_ value: Genre)

    @objc(removeToGenreObject:)
    @NSManaged public func removeFromToGenre(_ value: Genre)

    @objc(addToGenre:)
    @NSManaged public func addToToGenre(_ values: NSSet)

    @objc(removeToGenre:)
    @NSManaged public func removeFromToGenre(_ values: NSSet)

}

extension Result : Identifiable {

}
