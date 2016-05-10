//
//  MLImageCache.swift
//  demo
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

public enum CacheType {
    case None, Memory, Disk
}

private let cacheReverseDNS = "com.jackWang.ML.ImageCache"
private let cacheIoQueue = "com.jackWang.ML.IoQueue"
private let instance = MLImageCache()

class MLImageCache {
    
    class var sharedInstance: MLImageCache {
        return instance
    }
    
    init(){
        fileManager = NSFileManager.defaultManager()
        
        let dstPath =  NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
        diskCachePath = (dstPath as NSString).stringByAppendingPathComponent(cacheReverseDNS)
        
        ioQueue = dispatch_queue_create(cacheIoQueue, DISPATCH_QUEUE_SERIAL)
        
    }
    
    /// 内存缓存
    var memoryCache:NSCache = NSCache()
    
    /// The largest cache cost of memory cache. The total cost is pixel count of all cached images in memory.
    var maxMemoryCost: UInt = 0 {
        didSet {
            self.memoryCache.totalCostLimit = Int(maxMemoryCost)
        }
    }
    
    /// 文件缓存
    var fileManager:NSFileManager! //文件
    let diskCachePath:String  //缓存路径
    
    private let ioQueue: dispatch_queue_t
}

extension MLImageCache {
    /**
     取得image
     
     - parameter key:               imageKey Url String
     - parameter completionHandler: 回调
     */
    func receiveImageForKey(key:String, completionHandler: ((UIImage?, CacheType!) -> ())?) -> Void {
        self.receiveMemeryCacheImageForKey(key) { (image, cacheType) in
            guard let image = image else {
                self.receiveFileCacheImageForKey(key, completionHandler: completionHandler)
                return
            }
            completionHandler!(image , .Memory)
        }
    }
    
    /**
     存取
     
     - parameter image:     图片
     - parameter imageData: imageData
     - parameter key:       imageKey Url String
     */
    func storageImage(image:UIImage, originalData:NSData?, key:String, isFileCache:Bool) -> Void {
        self.storageMemeryCacheImage(image, key: key)
        if isFileCache {
            self.storageFileCacheImage(image, originalData: originalData, key: key)
        }
    }
}

// MARK: - 内存缓存存取
extension MLImageCache {
    /**
     存取
     
     - parameter image:     图片
     - parameter imageData: imageData
     - parameter key:       imageKey Url String
     */
    func storageMemeryCacheImage(image:UIImage, key:String) -> Void {
        self.memoryCache.setObject(image, forKey: key)
    }
    
    /**
     取得内存中的image
     
     - parameter key:               imageKey Url String
     - parameter completionHandler: completionHandler
     */
    func receiveMemeryCacheImageForKey(key:String, completionHandler: ((UIImage?, CacheType!) -> ())?) -> Void {
        let image = self.memoryCache.objectForKey(key) as? UIImage
        completionHandler!(image , .Memory)
    }
}

// MARK: - 文件缓存存取
extension MLImageCache {
    /**
     存入图片到disk
     
     - parameter data: image
     - parameter key:  key url string
     */
    func storageFileCacheImage(image:UIImage, originalData:NSData?, key:String) -> Void {
        dispatch_async(ioQueue) {
            if let data = originalData {
                if !self.fileManager.fileExistsAtPath(self.diskCachePath) {
                    do {
                        try self.fileManager.createDirectoryAtPath(self.diskCachePath, withIntermediateDirectories: true, attributes: nil)
                    } catch _ {}
                }
                self.fileManager.createFileAtPath(self.cachePathForKey(key), contents: data, attributes: nil)
                print(self.cachePathForKey(key))
                print(NSData(contentsOfFile: self.cachePathForKey(key)))
            }
        }
        print(NSData(contentsOfFile: self.cachePathForKey(key)))
    }
    
    /**
     获取磁盘缓存文件
     
     - parameter key:               url String
     - parameter completionHandler: completionHandler description
     */
    func receiveFileCacheImageForKey(key:String, completionHandler: ((UIImage?, CacheType!) -> ())?) -> Void {
//        let queue = dispatch_queue_create("tssssssss", DISPATCH_QUEUE_SERIAL)
        dispatch_async(ioQueue) {
            guard let image  = self.diskImageForKey(key) else {
                completionHandler!(nil , .Memory)
                return
            }
            self.storageMemeryCacheImage(image, key: key)
            completionHandler!(image , .Memory)
        }
    }
}

// MARK: - file path
extension MLImageCache {
    /**
     cache path
     
     - parameter key: url string
     
     - returns: cache path
     */
    func cachePathForKey(key: String) -> String {
        return (diskCachePath as NSString).stringByAppendingPathComponent(key.ml_MD5)
    }
    
    func diskImageForKey(key: String) -> UIImage? {
        guard let data = diskImageDataForKey(key) else {
            return nil
        }
        guard let image = UIImage().ml_image(data, scale: 1) else {
            return nil
        }
        return image
    }
    
    func diskImageDataForKey(key: String) -> NSData? {
        let filePath = cachePathForKey(key)
        return NSData(contentsOfFile: filePath)
    }
}