//
//  MLImageDowloadManager.swift
//  demo
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

//下载进度
public typealias DownloadProgressBlock = ((receivedSize: Int64, totalSize: Int64 , originData: NSData?) -> ())

private let instance = MLImageDowloadManager()

class MLImageDowloadManager {
    
    var imageDowloader = MLImageDowloader.defaultDownloader
    
    var imageCache = MLImageCache.sharedInstance
    
    class var instanceManager: MLImageDowloadManager {
        return instance
    }
    
    func reciveImageResoure(URL: NSURL,
                            progressBlock: DownloadProgressBlock,
                            completionHandler:MLImageDownloaderCompletionHandler) -> Void{
        self.reciveImageFromCache(URL, progressBlock: progressBlock, completionHandler: completionHandler)
    }
}

extension MLImageDowloadManager {
    
    func reciveImageFromCache(URL:NSURL,
                              progressBlock: DownloadProgressBlock,
                              completionHandler:MLImageDownloaderCompletionHandler) -> Void {
        imageCache.receiveImageForKey(URL.absoluteString) { (image, cacheType) in
            if image != nil {
                completionHandler(image: image, error: nil, cacheType: cacheType, imageURL: URL,originalData: nil)
            } else {
//                self.imageDowloader.downloaderImage(URL, progressBlock: progressBlock, completionHandler: completionHandler)
                self.reciveImageFromWithUrlToCache(URL, progressBlock: progressBlock, completionHandler: completionHandler)
            }
        }
    }
    
    
    func reciveImageFromWithUrlToCache(URL: NSURL,
                                       progressBlock: DownloadProgressBlock,
                                       completionHandler:MLImageDownloaderCompletionHandler) -> Void {
//        self.imageDowloader.downloaderImage(URL, progressBlock: progressBlock, completionHandler: completionHandler)
        self.imageDowloader.downloaderImage(URL, progressBlock: progressBlock) { (image, error, cacheType, imageURL, originalData) in
            self.imageCache.storageImage(image!, imageData: originalData!, key: URL.absoluteString)
            completionHandler(image: image, error: error, cacheType: cacheType, imageURL: URL,originalData: originalData)
        }
    }
}