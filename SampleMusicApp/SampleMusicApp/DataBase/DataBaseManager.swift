//
//  DataBaseManager.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//

import Foundation
import CoreData

struct DBConstants {
    static let dataBaseModelNamed = "SampleMusicApp"
    struct Entity {
        static let entityAlbum = "Album"
        static let entityResult = "Result"
        static let entityGenre = "Genre"
        static let entityAuthor = "Author"
        static let entityLink = "Link"

    }
}

class DataBaseManager {

    private init() {}

    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return DataBaseManager.persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
            /*
             The persistent container for the application. This implementation
             creates and returns a container, having loaded the store for the
             application to it. This property is optional since there are legitimate
             error conditions that could cause the creation of the store to fail.
            */
        let container = NSPersistentContainer(name: DBConstants.dataBaseModelNamed)
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                     
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()

    // MARK: - Core Data Saving support
    class func saveContext () {
        let context = DataBaseManager.getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
            }
        }
    }
    
}


extension DataBaseManager {
        class func getAlbum() -> Array<Album> {
            let all = NSFetchRequest<Album>(entityName: DBConstants.Entity.entityAlbum)
            var allAlbums = [Album]()

            do {
                let fetched = try DataBaseManager.getContext().fetch(all)
                allAlbums = fetched
            } catch {
                //TODO: Handle Error
            }
            return allAlbums
        }
    
    
    class func saveAlbumToDB (_ albumModel: AlbumAPIModel) {
        DataBaseManager.deleteAllRecords(entityName: DBConstants.Entity.entityAlbum)
        DataBaseManager.deleteAllRecords(entityName: DBConstants.Entity.entityAuthor)
        DataBaseManager.deleteAllRecords(entityName: DBConstants.Entity.entityGenre)
        DataBaseManager.deleteAllRecords(entityName: DBConstants.Entity.entityLink)
        DataBaseManager.deleteAllRecords(entityName: DBConstants.Entity.entityResult)

        guard let albumObject = DataBaseManager.add(Album.self) else {
            return
        }
        
        albumObject.title = albumModel.title
        albumObject.id = albumModel.id
        albumObject.copyright = albumModel.copyright
        albumObject.feedupdated = albumModel.updated
        
        guard let authorObject =  DataBaseManager.add(Author.self) else {
            return
        }
        
        authorObject.name = albumModel.author?.name
        authorObject.url = albumModel.author?.url
        
        
        for link in albumModel.links ?? [] {
            
            guard let linkObject = DataBaseManager.add(Link.self) else {
                return
            }

            linkObject.ourSelf = link.ourSelf
            albumObject.addToToLink(linkObject)
        }

        for r in albumModel.results ?? [] {
            guard let resultObject = DataBaseManager.add(Result.self) else {
                return
            }
            resultObject.artistId = r.artistId
            resultObject.artistName = r.artistName
            resultObject.artistUrl = r.artistUrl
            resultObject.artworkUrl100 = r.artworkUrl100
            resultObject.contentAdvisoryRating = r.contentAdvisoryRating
            resultObject.id = r.id
            resultObject.kind = r.kind
            resultObject.name = r.name
            resultObject.releaseDate = r.releaseDate
            resultObject.url = r.url
            resultObject.releaseDate = r.releaseDate
            for g in r.genres ?? [] {
                
                guard let genreObject = DataBaseManager.add(Genre.self) else {
                    return
                }
                
                genreObject.genreId = g.genreId
                genreObject.name = g.name
                genreObject.url = g.url
                resultObject.addToToGenre(genreObject)
            }
            albumObject.addToToResult(resultObject)
        }
        
        DataBaseManager.saveContext()
    }
    
    
}

extension DataBaseManager {
    
    class func add<T: NSManagedObject> (_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: DataBaseManager.getContext()) else { return nil }
        let object = T(entity: entity, insertInto: DataBaseManager.getContext())
        return object
    }
    
    class func deleteAllRecords(entityName : String) {

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try DataBaseManager.getContext().execute(deleteRequest)
            try DataBaseManager.getContext().save()
        } catch {
        }
    }
}

extension DataBaseManager {
    class func getAlbumCopyright() -> String {
        if let cr = DataBaseManager.getAlbum().first {
            return cr.copyright ?? ""
        }
        return ""
    }
}
