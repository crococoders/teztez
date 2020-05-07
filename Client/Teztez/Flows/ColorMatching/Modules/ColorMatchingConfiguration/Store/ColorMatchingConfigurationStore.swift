//
//  ColorMatchingConfigurationStore.swift
//  Teztez
//
//  Created by Adlet on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

enum ColorMatchingBlockType {
    case header(viewModel: ActivityHeaderViewModel)
    case selectDuration(viewModel: ActivitySelectValueViewModel)
}

private enum Constants {
    static let durationList: [Int] = [30, 45, 60]
    static let defaultDuration: Int = 30
    static let score = 100
    static let measure = "s"
}

final class ColorMatchingConfigurationStore {
    enum Action {
        case didLoadView
        case didSelectDuration(duration: Int)
        case didStartDidTap
    }

    enum State {
        case initial(blocks: [ColorMatchingBlockType])
        case updated(block: ColorMatchingBlockType)
        case configured(configuration: ColorMatchingConfiguration)
    }

    var durationList = Constants.durationList

    private var blocks: [ColorMatchingBlockType] = []
    private var headerViewModel: ActivityHeaderViewModel
    private var selectValueViewModel: ActivitySelectValueViewModel
    private var selectedDuration = Constants.defaultDuration

    @Published private(set) var state: State?

    init() {
        headerViewModel = ActivityHeaderViewModel(title: R.string.matching.title(),
                                                  description: R.string.matching.description(),
                                                  iconViewModel: ActivitiesIconViewModel(type: .colorMatch))
        selectValueViewModel = ActivitySelectValueViewModel(title: R.string.matching.durationTitle(),
                                                            description: R.string.matching.durationDescription(),
                                                            value: "\(Constants.defaultDuration)" + Constants.measure)
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            blocks = getInitialBlocks()
            state = .initial(blocks: blocks)
        case let .didSelectDuration(duration):
            selectedDuration = duration
            selectValueViewModel.value = "\(duration)" + Constants.measure
            state = .updated(block: .selectDuration(viewModel: selectValueViewModel))
        case .didStartDidTap:
            let configuration = ColorMatchingConfiguration(duration: selectedDuration, score: Constants.score)
            state = .configured(configuration: configuration)
        }
    }

    private func getInitialBlocks() -> [ColorMatchingBlockType] {
        return [.header(viewModel: headerViewModel),
                .selectDuration(viewModel: selectValueViewModel)]
    }
}
