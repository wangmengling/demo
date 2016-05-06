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
    
    var downloader: MLImageDowloader
    
    class var sharedManager: MLImageDowloadManager {
        return instance
    }
    
    init(){
        downloader = MLImageDowloader.defaultDownloader
    }
}

//MARK 接受数据：网络下载/缓存
extension MLImageDowloadManager {
    func reciveImageResoure(URL:NSURL, progressBlock:MLImageDownloaderProgressBlock, completionHandler: MLImageDownloaderCompletionHandler) -> Void {
        downloader.downloaderImage(URL, progressBlock: progressBlock, completionHandler: completionHandler)
    }
}