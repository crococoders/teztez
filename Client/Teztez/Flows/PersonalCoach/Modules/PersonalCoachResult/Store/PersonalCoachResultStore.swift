//
//  PersonalCoachResultStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 02/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

final class PersonalCoachResultStore {
    enum Action {
        case didLoadView
    }

    enum State {
        case initial(speedResult: String)
    }

    private let speed: Int

    @Published private(set) var state: State?

    init(speed: Int) {
        self.speed = speed
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            state = .initial(speedResult: "\(speed) wpm")
        }
    }
}
