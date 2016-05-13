//
//  AppState.swift
//  demo
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var counter: Int = 0
    var navigationState = NavigationState()
}