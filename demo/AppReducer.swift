//
//  AppReducer.swift
//  demo
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import Foundation
import ReSwift


struct AppReducer: Reducer {
    
    func handleAction(action: Action, state: State?) -> State {
        return State(
            navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
            authenticationState: authenticationReducer(state?.authenticationState, action: action),
            repositories: repositoriesReducer(state?.repositories, action: action),
            bookmarks: bookmarksReducer(state?.bookmarks, action: action)
        )
    }
    
}

func authenticationReducer(state: AuthenticationState?, action: Action) -> AuthenticationState {
    var state = state ?? initialAuthenticationState()
    
    switch action {
    case _ as SwiftFlowInit:
        break
    case let action as SetOAuthURL:
        state.oAuthURL = action.oAuthUrl
    case let action as UpdateLoggedInState:
        state.loggedInState = action.loggedInState
    default:
        break
    }
    
    return state
}