//
//  Link+CoreDataProperties.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//
//

import Foundation
import CoreData


extension Link {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Link> {
        return NSFetchRequest<Link>(entityName: "Link")
    }

    @NSManaged public var ourSelf: String?

}

extension Link : Identifiable {

}
