//
//  MLImageCache.swift
//  demo
//
//  Created by jackWang on 16/5/8.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

public enum CacheType {
    case None, Memory, Disk
}

private let instance = MLImageCache()

class MLImageCache {
    
    class var sharedInstance: MLImageCache {
        return instance
    }
    
    init(){
        fileManager = NSFileManager.defaultManager()
    }
    
    var memoryCache:NSCache = NSCache()
    
    /// The largest cache cost of memory cache. The total cost is pixel count of all cached images in memory.
    var maxMemoryCost: UInt = 0 {
        didSet {
            self.memoryCache.totalCostLimit = Int(maxMemoryCost)
        }
    }
    
    var fileManager:NSFileManager
}

extension MLImageCache {
    func storageImage(image:UIImage, imageData:NSData, key:String) -> Void {
        self.memoryCache.setObject(image, forKey: key)
        print(self.memoryCache.objectForKey(key))
    }
}

extension MLImageCache {
    func receiveImageForKey(key:String, completionHandler: ((UIImage?, CacheType!) -> ())?) -> Void {
        let image = self.memoryCache.objectForKey(key) as? UIImage
        completionHandler!(image , .Memory)
    }
}