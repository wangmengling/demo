//
//  ImageView+MLImageDowload.swift
//  demo
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit


extension UIImageView {
<<<<<<< HEAD
    func set_MLImageWithURL(URL:NSURL,
                            placeHolder:UIImage? = nil,
                            progressBlock:MLImageDownloaderProgressBlock? = nil,
                            completionHandler:MLImageDownloaderCompletionHandler? = nil) -> Void {
        if placeHolder != nil {
            self.image = placeHolder
        }else{
            self.image = UIImage()
        }
        MLImageDowloadManager.sharedManager.reciveImageResoure(URL, progressBlock: { (receivedSize, totalSize, originData) in
//                let image = UIImage().ml_image(originData!, scale: 1)
//                self.image = image
            }) { (image, error, imageURL, originalData) in
=======
    func set_MLImageWithURL(URL:NSURL) -> Void {
//        MLImageDowloader.defaultDownloader.downloaderImage(URL, progressBlock: { (receivedSize, totalSize, originData) in
//            let image = UIImage().ml_image(originData!, scale: 1)
//            self.image = image
//            }) { (image, error, cacheType ,imageURL, originalData) in
//            self.image = image
//        }
        MLImageDowloadManager.instanceManager.reciveImageResoure(URL, progressBlock: { (receivedSize, totalSize, originData) in
//                let image = UIImage().ml_image(originData!, scale: 1)
            }) { (image, error, cacheType, imageURL, originalData) in
>>>>>>> origin/master
                self.image = image
        }
        
    }
}