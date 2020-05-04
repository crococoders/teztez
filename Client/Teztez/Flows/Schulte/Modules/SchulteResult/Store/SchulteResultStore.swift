//
//  SchulteResultStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 04/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

final class SchulteResultStore {
    enum Action {
        case didLoadView
    }

    enum State {
        case initial(totalTime: String)
    }

    private let totalTime: String

    @Published private(set) var state: State?

    init(totalTime: String) {
        self.totalTime = totalTime
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            state = .initial(totalTime: totalTime)
        }
    }
}
