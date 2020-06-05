//
//  ColorMatchingResultStore.swift
//  Teztez
//
//  Created by Adlet on 06/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

final class ColorMatchingResultStore {
    enum Action {
        case didLoadView
    }

    enum State {
        case initial(scoreResult: String)
    }

    private let score: Int

    @Published private(set) var state: State?

    init(score: Int) {
        self.score = score
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            state = .initial(scoreResult: "\(score)pt")
        }
    }
}
