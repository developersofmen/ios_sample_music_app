//
//  UIImageViewExtension.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//

import Foundation
import UIKit

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func imageFromServerURL(urlString : String) {
        
        self.image = UIImage(named: "placeholder")

        if let url = URL(string: urlString) {
            
            // check cached image
            if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
                self.image = cachedImage
                return
            }
            
            // if not, download image from url
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let _ = error {
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data!) {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self.image = image
                    }
                }
                
            }).resume()
        }
    }
}
