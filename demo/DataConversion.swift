//
//  DataConversion.swift
//  demo
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation


public struct DataConversion<Element:DataConversionProtocol> {
    public typealias E = Element
}

// MARK: - JSON Map
extension DataConversion {
    /// Maps a JSON dictionary to an object that conforms to Mappable
    public func map(JSONDictionary: [String : AnyObject]) -> E? {
        let dataMap = DataMap(JSONDictionary: JSONDictionary)
        if var object = E() {
            object.mapping(dataMap)
            return object
        }
        return nil
    }
    
    public func map(JSON:AnyObject?) -> E? {
        if let JSON = JSON as? [String : AnyObject] {
            return map(JSON)
        }
        return nil
    }
}

// MARK: - Array
extension DataConversion {
    public func mapArray(JSONDictionaryArray: [[String : AnyObject]]) -> [E]? {
        let result = JSONDictionaryArray.flatMap(map)
        return result
    }
    
    public func mapArray(JSON: AnyObject?) -> [E] {
        if let JSONArray = JSON as? [[String : AnyObject]] {
            return mapArray(JSONArray)
        }
        return []
    }
    
    public func mapArray(JSONString:String) -> [E] {
        if let JSONArray = self.parseJSONString(JSONString){
            return mapArray(JSONArray)
        }
        return []
    }
    
    public func mapArray(JSONData:NSData) -> [E] {
        if let JSONArray = self.parseJSONData(JSONData){
            return mapArray(JSONArray)
        }
        return []
    }
}

// MARK: - NO JSON  ->  JSON
extension DataConversion {
    public func parseJSONString(JSON: String) -> AnyObject? {
        let data = JSON.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        if let data = data {
            let parsedJSON: AnyObject?
            do {
                parsedJSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            } catch let error {
                print(error)
                parsedJSON = nil
            }
            return parsedJSON
        }
        
        return nil
    }
    
    public func parseJSONData(JSON: NSData) -> AnyObject? {
        let parsedJSON: AnyObject?
        do {
            parsedJSON = try NSJSONSerialization.JSONObjectWithData(JSON, options: NSJSONReadingOptions.AllowFragments)
        } catch let error {
            print(error)
            parsedJSON = nil
        }
        return parsedJSON
    }
}





//---------------- infix operator <-> {}
//---------------- String Int ......
public func <-> <T>(inout field: T!, right: DataMap) {
    modelOrJson(&field, right: right)
}

public func <-> <T>(inout field: T?, right: DataMap) {
    modelOrJson(&field, right: right)
}

public func <-> <T>(inout field: T, right: DataMap) {
    modelOrJson(&field, right: right)
}

//----------------- DataConversionProtocol
public func <-> <T:DataConversionProtocol>(inout field: T, right: DataMap) {
    guard let object:T = DataConversion().map(right.value()) else {
        return
    }
    field = object
}

public func <-> <T:DataConversionProtocol>(inout field: T!, right: DataMap) {
    guard let object:T = DataConversion().map(right.value()) else {
        return
    }
    field = object
}

public func <-> <T:DataConversionProtocol>(inout field: T?, right: DataMap) {
    guard let object:T = DataConversion().map(right.value()) else {
        return
    }
    field = object
}

//----------------- Array<TDataConversionProtocol>
public func <-> <T:DataConversionProtocol>(inout field: Array<T>, right: DataMap) {
    guard let object:Array<T> = DataConversion().mapArray(right.value()) else {
        return
    }
    field = object
}

/// Object of Raw Representable type
public func <-> <T: RawRepresentable>(inout left: T, right: DataMap) {
    guard let raw = right.currentValue as? T.RawValue  else{
        return
    }
    guard let value = T(rawValue: raw) else {
        return
    }
    left = value
}

/// Optional Object of Raw Representable type
public func <-> <T: RawRepresentable>(inout left: T?, right: DataMap) {
    guard let raw = right.currentValue as? T.RawValue  else{
        return
    }
    let value = T(rawValue: raw)
    left = value
}

/// Implicitly Unwrapped Optional Object of Raw Representable type
public func <-> <T: RawRepresentable>(inout left: T!, right: DataMap) {
    guard let raw = right.currentValue as? T.RawValue  else{
        return
    }
    guard let value = T(rawValue: raw) else {
        return
    }
    left = value
}

infix operator <-> {}

func modelOrJson <T>(inout field: T, right: DataMap) {
    if right.toJSON == false {
        guard let object:T = right.value() else {
            return
        }
        field = object
    }else {
        toJSON(field, map: right)
    }
}

func toJSON<T>(field: T?, map: DataMap) {
    if map.toJSON == false {
        return
    }
    guard let value = field else {
        return
    }
    if let x = value as? AnyObject where false
        || x is NSNumber // Basic types
        || x is Bool
        || x is Int
        || x is Double
        || x is Float
        || x is String
        || x is Array<NSNumber> // Arrays
        || x is Array<Bool>
        || x is Array<Int>
        || x is Array<Double>
        || x is Array<Float>
        || x is Array<String>
        || x is Array<AnyObject>
        || x is Array<Dictionary<String, AnyObject>>
        || x is Dictionary<String, NSNumber> // Dictionaries
        || x is Dictionary<String, Bool>
        || x is Dictionary<String, Int>
        || x is Dictionary<String, Double>
        || x is Dictionary<String, Float>
        || x is Dictionary<String, String>
        || x is Dictionary<String, AnyObject>
    {
        map.JSONDataDictionary[map.currentKey!] = x
    }
}
