//
//  MyNetWorkRequest.swift
//  demo
//
//  Created by apple on 16/4/22.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation

enum Method: String {
    case GET = "GET"
    case POST = "POST"
}

/**
 *  网络请求
 */
struct NetWork {
    static func request(method: Method, url: String, params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), callback: (data: AnyObject!, response: NSURLResponse!, error: NSError!) -> Void) {
        var manager = NetWorkManager(method: method, url: url, params: params, callback: callback)
        manager.resume()
    }
}

// MARK: - session
struct NetWorkManager {
    
    //NSMutableURLRequest
    let method: Method!
    let params: Dictionary<String, AnyObject>
    let url:String!
    var request:NSMutableURLRequest!
    
    //NSURLSession
    let session:NSURLSession! = NSURLSession.sharedSession()
    let callback: (data: AnyObject!, response: NSURLResponse!, error: NSError!) -> Void
    var task: NSURLSessionTask!
    
    
    init(method:Method, url:String, params:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), callback: (data: AnyObject!, response: NSURLResponse!, error: NSError!) -> Void) {
        self.method = method
        self.params = params
        self.url = url
        self.callback = callback
        self.request = NSMutableURLRequest(URL: NSURL(string: url)!)
    }
    
    //请求并异步返回数据
    mutating func fireTask() {
        task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if data == nil {
                return
            }
            let json: AnyObject?
            do {
                json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            } catch let error {
                print(error)
            }
            self.callback(data: json, response: response, error: error)
        })
        task.resume()
    }
    
    mutating func resume() -> Void {
        self.buildRequest()
        self.fireTask()
    }
}

// MARK: - 设置 request  的参数 body
extension NetWorkManager {
    mutating func buildRequest() {
        if self.method == .GET && self.params.count > 0 {
            self.request = NSMutableURLRequest(URL: NSURL(string: url + "?" + buildParams(self.params))!)
        }
         
        request.HTTPMethod = self.method.rawValue
        
        if self.params.count > 0 {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        
        self.buildBody()
    }
    
    //非GET
    func buildBody() {
        if self.params.count > 0 && self.method != .GET {
            request.HTTPBody = buildParams(self.params).dataUsingEncoding(NSUTF8StringEncoding)
        }
    }
}

// MARK: - 解析 request 的 params
extension NetWorkManager {
    // 从 Alamofire 偷了三个函数
    
    func buildParams(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sort(<) {
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key, value)
        }
        
        return (components.map{"\($0)=\($1)"} as [String]).joinWithSeparator("&")
    }
    
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.appendContentsOf([(escape(key), escape("\(value)"))])
        }
        
        return components
    }
    
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
}