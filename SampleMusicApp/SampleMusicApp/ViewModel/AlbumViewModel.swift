//
//  AlbumViewModel.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//

import Foundation

struct AlbumViewModel {
    
    /// Private method to save album data from api to database
    /// - Parameter albumAPIModel: album model from api
    private func saveAlbumDataToDB(albumAPIModel:AlbumAPIModel?) {
        if let album = albumAPIModel {
            DataBaseManager.saveAlbumToDB(album)
        }
    }
    
    /// get album data from database
    /// - Returns: Album manage contex model
    func getAlbumDataFromDB()->Album?{
        return DataBaseManager.getAlbum().first
    }
    
    /// fetch album data from database
    /// - Parameters:
    ///   - success: success completion, return album manage contex object
    ///   - failure: failure completion, return error message
    func fetchAndRefreshAlbumData(success: @escaping ((Album?) -> Void),failure: @escaping ((String) -> Void)) {
        
        let internetAvailable = Reachability.isConnectedToNetwork()
        
        if internetAvailable {
            NetworkManager.shared.getNetworkCall(strEndpoint: Constants.Networking.APIEndPoint.albums, params: [String:Any]()) { (result) in
                
                let decoder = JSONDecoder()
                do {
                    let rootJson = try decoder.decode(RootJson.self, from: result.data)
                    //Save to db
                    self.saveAlbumDataToDB(albumAPIModel: rootJson.album)
                    success(self.getAlbumDataFromDB())
                } catch {
                    failure(Constants.Message.unknownError)
                }
            } failure: { (error) in
                failure(error.msg)
            }
        }
        else {
            failure(Constants.Message.connectionLost)
        }
    }
}
