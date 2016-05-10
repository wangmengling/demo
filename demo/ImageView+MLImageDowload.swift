//
//  ImageView+MLImageDowload.swift
//  demo
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit


extension UIImageView {
    func set_MLImageWithURL(URL:NSURL,
                            placeHolder:UIImage? = nil,
                            progressBlock:MLImageDownloaderProgressBlock? = nil,
                            completionHandler:MLImageDownloaderCompletionHandler? = nil) -> Void {
        if placeHolder != nil {
            self.image = placeHolder
        }else{
            self.image = UIImage()
        }
        
        MLImageDowloadManager.instanceManager.reciveImageResoure(URL, progressBlock: { (receivedSize, totalSize, originData) in
                progressBlock?(receivedSize: receivedSize, totalSize: totalSize , originData: originData)
            }) { (image, error, cacheType, imageURL, originalData) in
                self.image = image
                completionHandler?(image: image, error: error, cacheType: cacheType, imageURL: URL,originalData: originalData)
        }
        
        
    }
}