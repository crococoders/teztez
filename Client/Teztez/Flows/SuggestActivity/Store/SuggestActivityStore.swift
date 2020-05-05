//
//  SuggestActivityStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 05/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

final class SuggestActivityStore {
    enum Action {
        case didSendFeedback(title: String, feedback: String)
        case didStartTextChange
        case didResetText
    }

    enum State {
        case reset
        case textChanging
        case sended
    }

    @Published private(set) var state: State?

    func dispatch(action: Action) {
        switch action {
        case .didSendFeedback:
            state = .sended
        case .didStartTextChange:
            state = .textChanging
        case .didResetText:
            state = .reset
        }
    }
}
