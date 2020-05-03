//
//  SchulteConfigurationStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

enum SchulteBlockType {
    case header(viewModel: ActivityHeaderViewModel)
    case inverse(viewModel: ActivitySwitchViewModel)
}

final class SchulteConfigurationStore {
    enum Action {
        case didLoadView
        case didChangeSwitchValue(value: Bool)
        case didTapStartButton
    }

    enum State {
        case initial(blocks: [SchulteBlockType])
        case configured(configuration: SchulteConfiguration)
    }

    private var blocks: [SchulteBlockType] = []
    private var headerViewModel: ActivityHeaderViewModel
    private var inverseViewModel: ActivitySwitchViewModel
    private var isInversed = false

    @Published private(set) var state: State?
    init() {
        headerViewModel = ActivityHeaderViewModel(title: R.string.schulteConfiguration.title(),
                                                  description: R.string.schulteConfiguration.description(),
                                                  iconViewModel: ActivitiesIconViewModel(type: .schulte))
        inverseViewModel = ActivitySwitchViewModel(title: R.string.schulteConfiguration.inverseTitle(),
                                                   description: R.string.schulteConfiguration.inverseDescription(),
                                                   switchTitle: R.string.schulteConfiguration.iverseSwitchTitle())
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            blocks = getInitialBlocks()
            state = .initial(blocks: blocks)
        case let .didChangeSwitchValue(value):
            isInversed = value
        case .didTapStartButton:
            let configuration = SchulteConfiguration(isInversed: isInversed)
            state = .configured(configuration: configuration)
        }
    }

    private func getInitialBlocks() -> [SchulteBlockType] {
        return [.header(viewModel: headerViewModel),
                .inverse(viewModel: inverseViewModel)]
    }
}
