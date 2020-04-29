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
        case didStartTextChange
        case didResetText
        case didTapCancelButton
    }

    enum State {
        case reset
        case textChanging
        case warned(viewModel: ActionSheetViewModel)
    }

    @Published private(set) var state: State?

    func dispatch(action: Action) {
        switch action {
        case .didStartTextChange:
            state = .textChanging
        case .didResetText:
            state = .reset
        case .didTapCancelButton:
            state = .warned(viewModel: getActionSheetViewModel())
        }
    }

    private func getActionSheetViewModel() -> ActionSheetViewModel {
        return ActionSheetViewModel(title: R.string.textInput.warningTitle(),
                                    cancelTitle: R.string.textInput.warningCancelTitle(),
                                    continueTitle: R.string.textInput.warningContinueTitle())
    }
}
