//
//  Constant.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//

import Foundation
import UIKit

struct Constants {
    
    struct Networking {
        static let baseURL      = "https://rss.applemarketingtools.com/api/v2/"
        
        //all api end points
        struct APIEndPoint {
            static let albums   = "us/music/most-played/100/albums.json"
        }
    }
    
    struct Message {
        static let unknownError     = "Something went wrong, please try again."
        static let connectionLost   = "You seem offline, Please check your network connectivity."
        static let noInternet       = "Please check your network connectivity and try again."
        static let requestTimeOut   = "Request time out, please try again."
        static let noRecord         = "No records found"
        
    }
    
}
