//
//  TopicsModel.swift
//  demo
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation

class TopicsModel:NSObject,JsonModelProtocol {
    var author: AuthorModel?
    var author_id: String!
    var tab: String?
    var content: String?
    var title: String?
    var visit_count: Int = 0
    var reply_count: Int = 0
    var top:Bool = false
//    var avatar_url:String? = "" //avatar_url":"https://avatars.githubusercontent.com/u/1147375?v=3&s=120"
    
    func setupReplaceObjectClass() -> [String : String] {
        return ["author": "AuthorModel"]
    }
}


