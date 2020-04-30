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

    private let actionSheetViewModel: ActionSheetViewModel

    @Published private(set) var state: State?

    init(actionSheetViewModel: ActionSheetViewModel) {
        self.actionSheetViewModel = actionSheetViewModel
    }

    func dispatch(action: Action) {
        switch action {
        case .didStartTextChange:
            state = .textChanging
        case .didResetText:
            state = .reset
        case .didTapCancelButton:
            state = .warned(viewModel: actionSheetViewModel)
        }
    }
}
