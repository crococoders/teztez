//
//  ActivitiesStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Combine

final class ActivitiesStore {
    enum Action {
        case didLoadView
    }

    enum State {
        case inital(rows: [ActivitiesRowType])
    }

    @Published private(set) var state: State?

    private var rows: [ActivitiesRowType] = []

    init() {}

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            rows = ActivitiesRowType.allCases
            state = .inital(rows: rows)
        }
    }
}
