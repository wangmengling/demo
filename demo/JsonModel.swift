//
//  JsonModel.swift
//  demo
//
//  Created by apple on 16/4/22.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation

protocol JsonModelProtocol {
    func setValue(value: AnyObject?, forKey key: String)
}

extension JsonModelProtocol {
    func setValue(value: AnyObject?, forKey key: String)  {
        
    }
}

struct JsonModel {
    static func jsonToModel(model:JsonModelProtocol) {
        
    }
}