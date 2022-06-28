//
//  AlbumModel.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//

//This model is for handling server response, parse and save to DB's NSManagedObject
import Foundation

struct RootJson: Codable {
    var album: AlbumAPIModel?
    
    private enum CodingKeys : String, CodingKey {
        case album = "feed"
    }
}

struct AlbumAPIModel: Codable {
    var title:String?
    var id:String?
    var author:AuthorModel?
    var links:[LinkModel]?
    var copyright:String?
    var icon:String?
    var updated:String?
    var results:[ResultModel]?
}

struct AuthorModel: Codable {
    var name:String?
    var url:String?
}

struct LinkModel: Codable {
    var ourSelf:String?
    
    private enum CodingKeys : String, CodingKey {
        case ourSelf = "self"
    }
}

struct ResultModel: Codable {
    var artistId:String?
    var artistName:String?
    var artistUrl:String?
    var artworkUrl100:String?
    var contentAdvisoryRating:String?
    var id:String?
    var kind:String?
    var name:String?
    var releaseDate:String?
    var url:String?
    var genres:[GenreModel]?
}

struct GenreModel: Codable {
    var genreId:String?
    var name:String?
    var url:String?
}
