//
//  Album+CoreDataProperties.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//
//

import Foundation
import CoreData


extension Album {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: String?
    @NSManaged public var copyright: String?
    @NSManaged public var icon: String?
    @NSManaged public var feedupdated: String?
    @NSManaged public var toLink: NSSet?
    @NSManaged public var toResult: NSSet?

}

// MARK: Generated accessors for toLink
extension Album {

    @objc(addToLinkObject:)
    @NSManaged public func addToToLink(_ value: Link)

    @objc(removeToLinkObject:)
    @NSManaged public func removeFromToLink(_ value: Link)

    @objc(addToLink:)
    @NSManaged public func addToToLink(_ values: NSSet)

    @objc(removeToLink:)
    @NSManaged public func removeFromToLink(_ values: NSSet)

}

// MARK: Generated accessors for toResult
extension Album {

    @objc(addToResultObject:)
    @NSManaged public func addToToResult(_ value: Result)

    @objc(removeToResultObject:)
    @NSManaged public func removeFromToResult(_ value: Result)

    @objc(addToResult:)
    @NSManaged public func addToToResult(_ values: NSSet)

    @objc(removeToResult:)
    @NSManaged public func removeFromToResult(_ values: NSSet)

}

extension Album : Identifiable {

}
