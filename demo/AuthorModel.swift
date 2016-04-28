//
//  AuthorModel.swift
//  demo
//
//  Created by jackWang on 16/4/28.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation
class AuthorModel: NSObject,JsonModelProtocol {
    var avatar_url: String?
    var loginname: String?
    func setupReplaceObjectClass() -> [String : String] {
        return [:]
    }
}