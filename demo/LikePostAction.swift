//
//  LikePostAction.swift
//  demo
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation
import ReSwift

struct LikePostAction: Action {
    let post: Post
    let userLikingPost: User
}
