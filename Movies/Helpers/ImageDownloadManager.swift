//
//  ImageDownloadManager.swift
//  Movies
//
//  Created by Faheem Rahman on 15/06/22.
//

import UIKit

class ImageDownloadManager: NSObject {
    
    static let sharedInstance = ImageDownloadManager()
    var imageCache:NSCache<NSString, UIImage>
    
    override init() {
        
        imageCache = NSCache()
    }
    
    // Retrieve image from cache
    func getImage(forUrl url:String) -> UIImage? {
        return imageCache.object(forKey: url as NSString)
    }
    
    // Adding image to cache
    func setImage(image:UIImage,forKey url:String) -> Void {
        imageCache.setObject(image, forKey: url as NSString)
    }
}


