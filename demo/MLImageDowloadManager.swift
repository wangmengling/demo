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
    
    var downloader: MLImageDowloader!
    var imageCache:MLImageCache!
    
    class var sharedManager: MLImageDowloadManager {
        return instance
    }
    
    init(){
        self.downloader = MLImageDowloader.defaultDownloader
        self.imageCache = MLImageCache.sharedManager
    }
}

//MARK 接受数据：网络下载/缓存
extension MLImageDowloadManager {
    func reciveImageResoure(URL:NSURL, progressBlock:MLImageDownloaderProgressBlock, completionHandler: MLImageDownloaderCompletionHandler) -> Void {
//        imageCache.reciveImageResoure()
        guard let image = imageCache.receiveImageForKey(URL.absoluteString, completionHandler: nil) else {
            downloader.downloaderImage(URL, progressBlock: progressBlock, completionHandler: completionHandler)
        }
    }
}