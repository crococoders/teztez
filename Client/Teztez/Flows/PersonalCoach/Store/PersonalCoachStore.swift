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
}

final class PersonalCoachStore {
    enum Action {
        case didLoadView
    }

    enum State {
        case initial(blocks: [PersonalCoachBlockType])
    }

    private var blocks: [PersonalCoachBlockType] = []

    @Published private(set) var state: State?

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            blocks = getInitialBlocks()
            state = .initial(blocks: blocks)
        }
    }

    private func getInitialBlocks() -> [PersonalCoachBlockType] {
        let headerViewModel = ActivityHeaderViewModel(title: R.string.personalCoach.title(),
                                                      description: R.string.personalCoach.description(),
                                                      iconViewModel: ActivitiesIconViewModel(type: .coach))
        let inputextViewModel = ActivityTextInputViewModel(title: R.string.personalCoach.inputTextTitle(),
                                                           description: R.string.personalCoach.inputTextDescription(),
                                                           actionTitle: R.string.personalCoach.inputTextDefaultText())
        return [.header(viewModel: headerViewModel),
                .inputText(viewModel: inputextViewModel)]
    }
}
