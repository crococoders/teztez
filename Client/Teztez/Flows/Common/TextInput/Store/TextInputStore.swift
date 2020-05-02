//
//  TextInputStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 27/04/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

final class TextInputStore {
    enum Action {
        case didSetText(text: String)
        case didStartTextChange
        case didResetText
        case didTapCancelButton
    }

    enum State {
        case textSet(text: String)
        case reset
        case textChanging
        case warned(viewModel: ActionSheetViewModel)
    }

    private let actionSheetViewModel: ActionSheetViewModel
    private var userText: String?

    @Published private(set) var state: State?

    init() {
        actionSheetViewModel = ActionSheetViewModel(title: R.string.textInput.alertTitle(),
                                                    cancelTitle: R.string.textInput.cancelTitle(),
                                                    continueTitle: R.string.textInput.continueTitle())
    }

    func dispatch(action: Action) {
        switch action {
        case let .didSetText(text):
            state = .textSet(text: text)
        case .didStartTextChange:
            state = .textChanging
        case .didResetText:
            state = .reset
        case .didTapCancelButton:
            state = .warned(viewModel: actionSheetViewModel)
        }
    }
}
