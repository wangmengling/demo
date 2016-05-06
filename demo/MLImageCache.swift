//
//  MLImageCache.swift
//  demo
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation

private let instance = MLImageCache()

class MLImageCache {
    class var sharedImage: MLImageCache {
        return instance
    }
    
    init() {
        self.fileManager = NSFileManager()
    }
    
    var maxMemoryCost: UInt = 0 {
        didSet {
            self.memoryCache.totalCostLimit = Int(maxMemoryCost)
        }
    }
    
    private let memoryCache = NSCache()
    
    private var fileManager: NSFileManager!
}