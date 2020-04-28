//
//  TextInputStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 27/04/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

final class TextInputStore {
    enum Action {
        case didTextChangeStart
        case didTextReset
    }

    enum State {
        case reset
        case textChanging
    }

    @Published private(set) var state: State?

    func dispatch(action: Action) {
        switch action {
        case .didTextChangeStart:
            state = .textChanging
        case .didTextReset:
            state = .reset
        }
    }
}
