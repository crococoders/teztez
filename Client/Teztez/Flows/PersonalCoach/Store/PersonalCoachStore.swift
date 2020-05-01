//
//  PersonalCoachStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 01/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

enum PersonalCoachBlockType {
    case header(viewModel: ActivityHeaderViewModel)
    case inputText(viewModel: ActivityTextInputViewModel)
    case selectSpeed(viewModel: ActivitySelectValueViewModel)
}

private enum Constants {
    static let speedList = [100, 125, 150, 175, 200, 225, 250, 275, 300, 325, 350]
    static let defaultSpeed = 100
    static let speedMeasure = "wpm"
}

final class PersonalCoachStore {
    enum Action {
        case didLoadView
        case didSelectSpeed(speed: Int)
    }

    enum State {
        case initial(blocks: [PersonalCoachBlockType])
        case updated(block: PersonalCoachBlockType)
    }

    var speedList = Constants.speedList

    private var blocks: [PersonalCoachBlockType] = []
    private var headerViewModel: ActivityHeaderViewModel
    private var inputextViewModel: ActivityTextInputViewModel
    private var selectValueViewModel: ActivitySelectValueViewModel
    private var selectedSpeed = Constants.defaultSpeed

    @Published private(set) var state: State?

    init() {
        headerViewModel = ActivityHeaderViewModel(title: R.string.personalCoach.title(),
                                                  description: R.string.personalCoach.description(),
                                                  iconViewModel: ActivitiesIconViewModel(type: .coach))
        inputextViewModel = ActivityTextInputViewModel(title: R.string.personalCoach.inputTextTitle(),
                                                       description: R.string.personalCoach.inputTextDescription(),
                                                       actionTitle: R.string.personalCoach.inputTextDefaultText())
        selectValueViewModel = ActivitySelectValueViewModel(title: R.string.personalCoach.selectSpeedTitle(),
                                                            description: R.string.personalCoach.selectSpeedDescription(),
                                                            value: "\(Constants.defaultSpeed) " + Constants.speedMeasure)
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            blocks = getInitialBlocks()
            state = .initial(blocks: blocks)
        case let .didSelectSpeed(speed):
            selectedSpeed = speed
            selectValueViewModel.value = "\(speed) " + Constants.speedMeasure
            state = .updated(block: .selectSpeed(viewModel: selectValueViewModel))
        }
    }

    private func getInitialBlocks() -> [PersonalCoachBlockType] {
        return [.header(viewModel: headerViewModel),
                .inputText(viewModel: inputextViewModel),
                .selectSpeed(viewModel: selectValueViewModel)]
    }
}
