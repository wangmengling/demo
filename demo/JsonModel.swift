//
//  JsonModel.swift
//  demo
//
//  Created by apple on 16/4/22.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation

public protocol JsonModelProtocol {
    
}

struct JsonModel {
    
    func jsonToModelArray(model:AnyObject, json:Array<AnyObject>) -> Array<Any> {
        let jsonToModelArray = json.map { (singleJson) -> Any in
            let singleJsonModel = self.jsonToModel(model,json: singleJson)
            return singleJsonModel
        }
        return jsonToModelArray
    }
    
    func jsonToModel(model:AnyObject, json:AnyObject) -> AnyObject? {
        let mirror = Mirror(reflecting: model)
        let modelString = NSStringFromClass(model.classForCoder)
        guard let cls = NSClassFromString(modelString) as? NSObject.Type else {
            return nil
        }
        let obj = cls.init()
        mirror.children.map { (child) -> Void in
            let value:AnyObject? = json.objectForKey(child.label!)
            obj.setValue(value, forKey: child.label!)
        }
        return obj
    }
    
    init(){
        
    }
}