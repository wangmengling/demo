//
//  StandardAction.swift
//  demo
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation
import ReSwift


struct StandardAction: Action {
    // identifies the action
    let type: String
    // provides information that is relevant to processing this action
    // e.g. details about which post should be favorited
    let payload: [String : AnyObject]?
    // this flag is used for serialization when working with ReSwift Recorder
    let isTypedAction: Bool
}