//
//  ImageDownloader.swift
//  Movies
//
//  Created by Faheem Rahman on 15/06/22.
//

import UIKit

class ImageDownloader: NSObject {
    
    func downloadAndCacheImage(url:String, onSuccess:@escaping (_ image:UIImage?, _ url: String) -> Void, onFailure:@escaping (_ error:Error?) -> Void) -> Void {
        
        let finalUrl = URL(string: url)
        
        if let image = ImageDownloadManager.sharedInstance.getImage(forUrl: url){
            onSuccess(image, url) // if exist in cache , retrieve from cache
        }else{
            URLSession.shared.dataTask(with: finalUrl!, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    onFailure(error)
                }else{
                    if let image = UIImage(data: data!){
                        ImageDownloadManager.sharedInstance.setImage(image: image, forKey: url) // add to cache
                        onSuccess(image, url)
                    }else{
                        onFailure(NSError(domain: "", code: 100, userInfo: ["reason":"Unable to download image"]))
                    }
                }
            }).resume()
        }
    }
}


