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
        case didSelectItem(itemType: ActivitiesItemType)
    }

    enum State {
        case inital(items: [ActivitiesItemType])
        case itemSelected(itemType: ActivitiesItemType)
    }

    private var items: [ActivitiesItemType] = []

    @Published private(set) var state: State?

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            items = ActivitiesItemType.allCases
            state = .inital(items: items)
        case let .didSelectItem(itemType):
            state = .itemSelected(itemType: itemType)
        }
    }
}
