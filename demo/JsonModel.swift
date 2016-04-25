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

extension JsonModelProtocol {
    func setValue(value: AnyObject?, forKey key: String)  {
        
    }
}

struct JsonModel {
    
    func jsonToModelArray(model:AnyObject, json:Array<AnyObject>) -> Array<Any> {
        let jsonToModelArray = json.map { (singleJson) -> Any in
            let singleJsonModel = self.jsonToModel(model,json: singleJson)
            return singleJsonModel
        }
        return jsonToModelArray
    }
    
    func jsonToModel(model:AnyObject, json:AnyObject) -> AnyObject {
        let mirror = Mirror(reflecting: model)
        mirror.children.map { (child) -> Void in
            let value:AnyObject? = json.objectForKey(child.label!)
            model.setValue(value, forKey: child.label!)
        }
        return model
    }
    
    init(model:AnyObject, json:AnyObject){
        if json.type == "Array" {
            self.jsonToModelArray(model, json: json as! Array<AnyObject>)
        } else {
            self.jsonToModel(model, json: json)
        }
    }
}