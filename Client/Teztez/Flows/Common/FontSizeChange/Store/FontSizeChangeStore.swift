//
//  FontSizeChangeStore.swift
//  Teztez
//
//  Created by Adlet on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let selectedFontSize: CGFloat = 15
}

final class FontSizeChangeStore {
    enum Action {
        case didChangeFontSize(value: CGFloat)
        case didTapDoneButton
        case didTapCancelButton
    }

    enum State {
        case changingFontSize(fontSize: CGFloat)
        case changeFontSizeFinished(fontSize: CGFloat)
        case cancelled
    }

    private var fontSize: CGFloat = Constants.selectedFontSize

    @Published private(set) var state: State?

    func dispatch(action: Action) {
        switch action {
        case let .didChangeFontSize(value):
            state = .changingFontSize(fontSize: value)
            fontSize = value
        case .didTapDoneButton:
            state = .changeFontSizeFinished(fontSize: fontSize)
        case .didTapCancelButton:
            state = .cancelled
        }
    }
}
