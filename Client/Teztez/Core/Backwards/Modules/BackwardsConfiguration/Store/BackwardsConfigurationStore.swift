//
//  BackwardsConfigurationStore.swift
//  Teztez
//
//  Created by Adlet on 5/2/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit
// swiftlint:disable all
enum BackwardsBlockType {
    case header(viewModel: ActivityHeaderViewModel)
    case inputText(viewModel: ActivityTextInputViewModel)
    case selectFont(viewModel: ActivityTextInputViewModel)
}

private enum Constants {
    static let defaultText = "Color is a great way to impart vitality, provide visual continuity, communicate status information, give feedback in response to user actions, and help people visualize data. Look to the system’s color scheme for guidance when picking app tint colors that look great individually and in combination, on both light and dark backgrounds. Use color judiciously for communication. The power of color to call attention to important information is heightened when used sparingly. For example, a red triangle that warns people of a critical problem becomes less effective when red is used elsewhere in an app for noncritical reasons. communication. The power of color to call attention to important information is heightened when used sparingly. For example, a red triangle that warns people of a critical problem becomes less effective when red is used elsewhere in an app for noncritical reasons. The power of color to call attention to important information is heightened when used sparingly. For example, a red triangle that warns people of a critical problem becomes less effective when red is used elsewhere in an app for noncritical reasons."
    static let fontSizeMeasure = "pt"
    static let defaultFontSize: CGFloat = 15
}

final class BackwardsConfigurationStore {
    enum Action {
        case didLoadView
        case didSetUserText(text: String)
        case didSelectFontSize(fontSize: CGFloat)
        case didStartDidTap
    }

    enum State {
        case initial(blocks: [BackwardsBlockType])
        case updated(block: BackwardsBlockType)
        case configured(configuration: BackwardsConfiguration)
    }

    @Published private(set) var state: State?

    private var blocks: [BackwardsBlockType] = []
    private var headerViewModel: ActivityHeaderViewModel
    private var inputTextViewModel: ActivityTextInputViewModel
    private var selectFontSizeViewModel: ActivityTextInputViewModel

    private var userText = Constants.defaultText
    private var selectedFontSize = Constants.defaultFontSize

    init() {
        headerViewModel = ActivityHeaderViewModel(title: R.string.backwardsConfiguration.title(),
                                                  description: R.string.backwardsConfiguration.description(),
                                                  iconViewModel: ActivitiesIconViewModel(type: .backwards))

        inputTextViewModel = ActivityTextInputViewModel(title: R.string.backwardsConfiguration.inputTextTitle(),
                                                        description: R.string.backwardsConfiguration.inputTextDescription(),
                                                        actionTitle: R.string.backwardsConfiguration.inputTextDefaultText())

        selectFontSizeViewModel = ActivityTextInputViewModel(title: R.string.backwardsConfiguration.selectFontSizeTitle(),
                                                             description: R.string.backwardsConfiguration.selectFontSizeDescription(),
                                                             actionTitle: "\(Constants.defaultFontSize.clean)" + Constants.fontSizeMeasure)
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            blocks = getBlocks()
            state = .initial(blocks: blocks)
        case let .didSetUserText(text):
            userText = text
            inputTextViewModel.actionTitle = R.string.backwardsConfiguration.inputTextYourText()
            state = .updated(block: .inputText(viewModel: inputTextViewModel))
        case let .didSelectFontSize(fontSize):
            selectedFontSize = fontSize
            selectFontSizeViewModel.actionTitle = "\(fontSize.clean)" + Constants.fontSizeMeasure
            state = .updated(block: .selectFont(viewModel: selectFontSizeViewModel))
        case .didStartDidTap:
            let configuration = BackwardsConfiguration(text: userText, fontSize: selectedFontSize)
            state = .configured(configuration: configuration)
        }
    }

    private func getBlocks() -> [BackwardsBlockType] {
        return [.header(viewModel: headerViewModel),
                .inputText(viewModel: inputTextViewModel),
                .selectFont(viewModel: selectFontSizeViewModel)]
    }
}
