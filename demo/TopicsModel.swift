//
//  TopicsModel.swift
//  demo
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation
import ObjectMapper

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

struct TopicssModel {
    var dd:String = "2"
}

enum TopicVisitCountEnum: Int {
    case Default = 0
    case One = 1
    case Two = 2
    case Three = 8661
    case Four = 1499
}

struct TopicModel: Mappable{
    var author: AuthorsModel?
    var author_id: String!
    var tab: String?
    var content: String?
    var title: String?
    var visit_count:  TopicVisitCountEnum?
    var reply_count: Int = 0
    var top:Bool = false
    //    var avatar_url:String? = "" //avatar_url":"https://avatars.githubusercontent.com/u/1147375?v=3&s=120"
    
    init?(_ map: Map){
        
    }
    
    init(){
        
    }
    
    mutating func mapping(map: Map) {
        author <- map["author"]
        author_id <- map["author_id"]
        tab <- map["tab"]
        content <- map["content"]
        title <- map["title"]
        visit_count <- map["visit_count"]
    }
    
    
}

struct TopicsssModel:DataConversionProtocol {
//    var author: AuthorssModel?
    var author_id: String!
    var tab: String!
    var content: String?
    var title: String?
    var visit_count: TopicVisitCountEnum? = TopicVisitCountEnum.Default
    var reply_count: Int = 0
    var top:Bool = false
    
    init(){
        
    }
    
    mutating func mapping(map: DataMap) {
//        author <-> map["author"]
        author_id <-> map["author_id"]
        tab <-> map["tab"]
        content <-> map["content"]
        title <-> map["title"]
        visit_count <-> map["visit_count"]
    }
}


