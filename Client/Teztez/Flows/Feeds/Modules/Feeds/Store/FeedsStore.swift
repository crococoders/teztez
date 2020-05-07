//
//  FeedsStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 05/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

final class FeedsStore {
    enum Action {
        case didLoadView
    }

    enum State {
        case initial(blocks: [Block])
    }

    @Published private(set) var state: State?
    let provider: FeedsProvider

    init() {
        provider = FeedsProvider()
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            provider.fetchFeeds { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(blocks):
                    self.state = .initial(blocks: blocks)
                case .failure:
                    break
                }
            }
        }
    }
}
