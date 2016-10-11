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
    fileprivate lazy var srorageToSQLite = SrorageToSQLite.instanceManager
    
//    public static let instanceManager:Storage<E> = {
//        return Storage<E>()
//    }()
    
    
    init(){
        
    }
}

extension Storage {
    
    mutating func objects(_ filter:String = "",sorted:(String,Bool) = ("",false),limit:(Int,Int) = (0,10)) -> Array<E> {
        if let object = E() {
            let dicArray = srorageToSQLite.objectsToSQLite(self.tableName(object))
            let data:DataConversion =  DataConversion<E>()
            let objectArray = data.mapArray(dicArray)
            return objectArray
        }
        return Array<E>()
    }
    
    public mutating func object(_ filter:String) -> E? {
        if let object = E() {
            let dic = srorageToSQLite.objectToSQLite(self.tableName(object),filter: filter)
            let data:DataConversion =  DataConversion<E>()
            let object = data.map(dic)
            return object
        }
        return nil
    }
}

extension Storage {
    
    /**
     add or update Object
     
     - parameter object: <#object description#>
     - parameter update: <#update description#>
     */
    mutating func add(_ object:E,update:Bool = false)  {
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
    
    mutating func addArray(_ objectArray:[E]?) {
        guard let objectArray = objectArray else {
            return
        }
        for (_,element) in objectArray.enumerated() {
            self.add(element)
        }
    }
}

extension Storage {
    public func delete(_ object:E)  {
        
    }
    
    public func deleteAll() {
        
    }
}

extension Storage {
    public func tableName(_ object:E) -> String {
        let objectsMirror = Mirror(reflecting: object)
        return String(describing: objectsMirror.subjectType)
    }
}
