//
//  MLImageDowloader.swift
//  demo
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

/// Progress update block of downloader.
public typealias MLImageDownloaderProgressBlock = DownloadProgressBlock

/// Completion block of downloader.
public typealias MLImageDownloaderCompletionHandler = ((image: UIImage?, error: NSError?, imageURL: NSURL?, originalData: NSData?) -> ())


private let defaultDownloaderName = "default"
private let instance = MLImageDowloader(name: defaultDownloaderName)

class MLImageDowloader {
    
    /// The duration before the download is timeout. Default is 15 seconds.
    var downloadTimeout: NSTimeInterval = 15.0
    
    var requestsUsePipeling = false
    
    
    var session: NSURLSession?
    var sessionDataTask: NSURLSessionDataTask?
    var sessionHandler:MLImageDownloaderSessionHandler?
    
    
    
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
    }
}




/// NSURLSessionDataDelegate 实现
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
        
    }
    
    /**
     This method is exposed since the compiler requests. Do not call it.
     */
    internal func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        print(task.countOfBytesExpectedToReceive)
        print(task.countOfBytesReceived)
        self.callBackImage(task)
    }
    
    
    /**
     This method is exposed since the compiler requests. Do not call it.
     */
    internal func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        
    }
    
    func callBackImage(task:NSURLSessionTask) {
//        let image = UIImage().ml_image(task, scale: <#T##CGFloat#>)
    }
}