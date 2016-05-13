//
//  CounterReducer.swift
//  demo
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation
import ReSwift

struct CounterReducer: Reducer {
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        var state = state ?? AppState()
        
        switch action {
        case _ as CounterActionIncrease:
            state.counter += 1
        case _ as CounterActionDecrease:
            state.counter -= 1
        default:
            break
        }
        
        return state
    }
    
}