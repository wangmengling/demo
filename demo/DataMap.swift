//
//  DataMap.swift
//  demo
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation

public class DataMap {
    public var JSONDictionary: [String : AnyObject] = [:]
    public var JSONDataDictionary: [String : AnyObject] = [:]
    public var currentValue: AnyObject?
    public var currentKey: String?
    public var toJSON:Bool = false
    
    init(JSONDictionary:[String : AnyObject]?){
        guard let JSONDictionary = JSONDictionary else {
            return
        }
        self.JSONDictionary = JSONDictionary
    }
    
    init(toJSON:Bool = false){
        self.toJSON = toJSON
    }
    
    public subscript(key:String) -> DataMap  {
        self.currentKey = key
        // check if a value exists for the current key
        // do this pre-check for performance reasons
        let object = JSONDictionary[key]
        let isNSNull = object is NSNull
        currentValue = isNSNull ? nil : object
        return self
    }
    
    public func value<T>(@autoclosure defaultValue:() -> T) -> T?{
        defaultValue()
        return self.currentValue as? T
    }
    
    public func value<T>() -> T? {
        return currentValue as? T
    }
}