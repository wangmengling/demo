//
//  Storage.swift
//  demo
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation
struct Storage<Element:DataConversionProtocol> {
    
    static let instanceManager:Storage<E> = {
        return Storage<E>()
    }()
    
    internal typealias E = Element
    private lazy var srorageToSQLite = SrorageToSQLite.instanceManager
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
    
    mutating func object() -> E {
        
    }
}

extension Storage {
    mutating func add(object:E) {
        guard let object:E = object else {
            return
        }
        if !srorageToSQLite.tableIsExists(object){
            srorageToSQLite.createTable(object)
        }
        srorageToSQLite.insert(object)
        return
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