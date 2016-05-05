//
//  MLImageDowloader.swift
//  demo
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

/// Progress update block of downloader. 下载进度
public typealias MLImageDownloaderProgressBlock = DownloadProgressBlock

/// Completion block of downloader.
public typealias MLImageDownloaderCompletionHandler = ((image: UIImage?, error: NSError?, imageURL: NSURL?, originalData: NSData?) -> ())

//回调
typealias CallbackPair = (progressBlock: MLImageDownloaderProgressBlock?, completionHander: MLImageDownloaderCompletionHandler?)


private let defaultDownloaderName = "default"
private let instance = MLImageDowloader(name: defaultDownloaderName)

/// 回调
class MLImageCallbacks  {
    var callbacks = [CallbackPair]()
    var responseData = NSMutableData()
}



class MLImageDowloader {
    
    /// The duration before the download is timeout. Default is 15 seconds.
    var downloadTimeout: NSTimeInterval = 15.0
    
    var requestsUsePipeling = false
    
    
    var session: NSURLSession?
    var sessionDataTask: NSURLSessionDataTask?
    var sessionHandler:MLImageDownloaderSessionHandler?
    
    var fetchLoads = [NSURL:MLImageCallbacks]() //所有的加载
    
    
    
    
    var sessionConfiguration = NSURLSessionConfiguration.ephemeralSessionConfiguration() {
        didSet {
            session = NSURLSession(configuration: sessionConfiguration, delegate: sessionHandler, delegateQueue: NSOperationQueue.mainQueue())
        }
    }
    
    /// 单例
    class var defaultDownloader:MLImageDowloader{
        return instance
    }
    
    
    /**
     初始化
     
     - parameter name: The name for the downloader. It should not be empty.
     
     - returns: MLImageDowloader object
     */
    init(name:String){
        sessionHandler = MLImageDownloaderSessionHandler()
        session = NSURLSession(configuration: sessionConfiguration, delegate: sessionHandler, delegateQueue: NSOperationQueue.mainQueue())
    }
}

// MARK: - dowloader
extension MLImageDowloader {
    func downloaderImage(URL: NSURL,
                         progressBlock: MLImageDownloaderProgressBlock,
                         completionHandler:MLImageDownloaderCompletionHandler) -> Void
    {
        /// 构建 request
        let request = NSMutableURLRequest(URL: URL, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: downloadTimeout)
        request.HTTPShouldUsePipelining = requestsUsePipeling
        
        /// 构建 dataTask
        sessionDataTask = session?.dataTaskWithRequest(request)
        sessionDataTask?.priority = NSURLSessionTaskPriorityDefault
        self.sessionHandler?.downloadHolder = self
        sessionDataTask?.resume()
        
        //注册回调
        registerProgressBlock(progressBlock, completionHandler: completionHandler, URL: URL)
    }
}

// MARK: - register callback
extension MLImageDowloader {
    internal func registerProgressBlock(progressBlock:MLImageDownloaderProgressBlock,completionHandler:MLImageDownloaderCompletionHandler, URL:NSURL){
        
        //本次加载数据的回调
        let callBacks = self.fetchLoads[URL] ?? MLImageCallbacks()
        let callbackPair = CallbackPair(progressBlock: progressBlock, completionHander: completionHandler)
        callBacks.callbacks.append(callbackPair)
        
        //注册回调
        self.fetchLoads[URL] = callBacks
        
    }
    
    func fetchLoadForKey(URL: NSURL) -> MLImageCallbacks? {
        var fetchLoad: MLImageCallbacks?
//        dispatch_sync(barrierQueue, { () -> Void in
            fetchLoad = self.fetchLoads[URL]
//        })
        return fetchLoad
    }
}




// MARK: - NSURLSessionDataDelegate 实现
class MLImageDownloaderSessionHandler: NSObject,NSURLSessionDataDelegate {
    var downloadHolder: MLImageDowloader?
    /**
     This method is exposed since the compiler requests. Do not call it.
     */
    internal func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        
        completionHandler(NSURLSessionResponseDisposition.Allow)
    }
    
    /**
     This method is exposed since the compiler requests. Do not call it.
     */
    internal func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        
        guard let downloader = downloadHolder else {
            return
        }
        
        if let URL = dataTask.originalRequest?.URL, fetchLoad = downloader.fetchLoadForKey(URL) {
            fetchLoad.responseData.appendData(data)
            
            for callbackPair in fetchLoad.callbacks {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callbackPair.progressBlock?(receivedSize: Int64(fetchLoad.responseData.length), totalSize: dataTask.response!.expectedContentLength, originData: data)
                })
            }
        }
    }
    
    /**
     This method is exposed since the compiler requests. Do not call it.
     */
    internal func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        self.callBackImage(task)
    }
    
    
    /**
     This method is exposed since the compiler requests. Do not call it.
     */
    internal func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
//        print(session.configuration)
        if challenge.protectionSpace.authenticationMethod.compare(NSURLAuthenticationMethodServerTrust).rawValue == 0 {
            if challenge.protectionSpace.host.compare("HOST_NAME").rawValue == 0 {
                completionHandler(.UseCredential, NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!))
            }
            
        } else if challenge.protectionSpace.authenticationMethod.compare(NSURLAuthenticationMethodHTTPBasic).rawValue == 0 {
            if challenge.previousFailureCount > 0 {
                completionHandler(NSURLSessionAuthChallengeDisposition.CancelAuthenticationChallenge, nil)
            } else {
                let credential = NSURLCredential(user:"username", password:"password", persistence: .ForSession)
                completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential,credential)
            }
        }

    }
    
    func callBackImage(task:NSURLSessionTask) {
//        let image = UIImage().ml_image(task, scale: <#T##CGFloat#>)
        guard let downloader = downloadHolder else {
            return
        }
        
        if let URL = task.originalRequest?.URL, fetchLoad = downloader.fetchLoadForKey(URL) {
            
            for callbackPair in fetchLoad.callbacks {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callbackPair.completionHander?(image: UIImage().ml_image(fetchLoad.responseData, scale: 1), error: nil, imageURL: URL, originalData: fetchLoad.responseData)
                })
            }
        }
    }
}