//
//  Storage.swift
//  demo
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation
public struct Storage<Element:DataConversionProtocol> {
    public typealias E = Element
    private lazy var srorageToSQLite = SrorageToSQLite.instanceManager
    
//    public static let instanceManager:Storage<E> = {
//        return Storage<E>()
//    }()
    
    
    init(){
        
    }
}

extension Storage {
    mutating func objects() -> Array<E>? {
        if let object = E() {
            let dicArray = srorageToSQLite.objectToSQLite(object)
            let data:DataConversion =  DataConversion<E>()
            let objectArray = data.mapArray(dicArray)
            return objectArray
        }
        return nil
    }
    
    public func object() -> E? {
        return nil
    }
}

extension Storage {
    public func filter(predicateFormat: String, _ args: AnyObject...) -> Array<E> {
        return []
    }
    
    /**
     Returns a `Results` containing all objects matching the given predicate in the results collection.
     
     - parameter predicate: The predicate with which to filter the objects.
     */
    public func filter(predicate: NSPredicate) -> Array<E> {
        return []
    }
}

extension Storage {
//    mutating func add(object:E) {
//        guard let object:E = object else {
//            return
//        }
//        if !srorageToSQLite.tableIsExists(object){
//            srorageToSQLite.createTable(object)
//        }
//        srorageToSQLite.insert(object)
//    }
    
    /**
     add or update Object
     
     - parameter object: <#object description#>
     - parameter update: <#update description#>
     */
    mutating func add(object:E,update:Bool = false)  {
        guard let object:E = object else {
            return
        }
        if !srorageToSQLite.tableIsExists(object){
            srorageToSQLite.createTable(object)
        }
        if update == true && srorageToSQLite.count(object) > 0{
            srorageToSQLite.update(object)
            return
        }
        srorageToSQLite.insert(object)
    }
    
    mutating func addArray(objectArray:[E]?) {
        guard let objectArray = objectArray else {
            return
        }
        for (_,element) in objectArray.enumerate() {
            self.add(element)
        }
    }
}

extension Storage {
    public func delete(object:E)  {
        
    }
    
    public func deleteAll() {
        
    }
}

extension Storage {
    
}