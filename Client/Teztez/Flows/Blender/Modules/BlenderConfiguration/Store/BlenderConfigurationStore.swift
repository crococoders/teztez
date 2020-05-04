//
//  BlenderConfigurationStore.swift
//  Teztez
//
//  Created by Adlet on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import UIKit
// swiftlint:disable all
enum BlenderBlockType {
    case header(viewModel: ActivityHeaderViewModel)
    case inputText(viewModel: ActivityTextInputViewModel)
    case selectFont(viewModel: ActivityTextInputViewModel)
}

private enum Constants {
    static let defaultText = "Color is a great way to impart vitality, provide visual continuity, communicate status information, give feedback in response to user actions, and help people visualize data. Look to the system’s color scheme for guidance when picking app tint colors that look great individually and in combination, on both light and dark backgrounds. Use color judiciously for communication. The power of color to call attention to important information is heightened when used sparingly. For example, a red triangle that warns people of a critical problem becomes less effective when red is used elsewhere in an app for noncritical reasons. communication. The power of color to call attention to important information is heightened when used sparingly. For example, a red triangle that warns people of a critical problem becomes less effective when red is used elsewhere in an app for noncritical reasons. The power of color to call attention to important information is heightened when used sparingly. For example, a red triangle that warns people of a critical problem becomes less effective when red is used elsewhere in an app for noncritical reasons."
    static let fontSizeMeasure = "pt"
    static let defaultFontSize: CGFloat = 15
}

final class BlenderConfigurationStore {
    enum Action {
        case didLoadView
        case didSetUserText(text: String)
        case didSelectFontSize(fontSize: CGFloat)
        case didStartDidTap
    }

    enum State {
        case initial(blocks: [BlenderBlockType])
        case updated(block: BlenderBlockType)
        case configured(configuration: BlenderConfiguration)
    }

    @Published private(set) var state: State?

    private var blocks: [BlenderBlockType] = []
    private var headerViewModel: ActivityHeaderViewModel
    private var inputTextViewModel: ActivityTextInputViewModel
    private var selectFontSizeViewModel: ActivityTextInputViewModel

    private var userText = Constants.defaultText
    private var selectedFontSize = Constants.defaultFontSize

    init() {
        headerViewModel = ActivityHeaderViewModel(title: R.string.blenderConfiguration.title(),
                                                  description: R.string.blenderConfiguration.description(),
                                                  iconViewModel: ActivitiesIconViewModel(type: .blender))

        inputTextViewModel = ActivityTextInputViewModel(title: R.string.blenderConfiguration.inputTextTitle(),
                                                        description: R.string.blenderConfiguration.inputTextDescription(),
                                                        actionTitle: R.string.blenderConfiguration.inputTextDefaultText())

        selectFontSizeViewModel = ActivityTextInputViewModel(title: R.string.blenderConfiguration.selectFontSizeTitle(),
                                                             description: R.string.blenderConfiguration.selectFontSizeDescription(),
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
            let configuration = BlenderConfiguration(text: userText, fontSize: selectedFontSize)
            state = .configured(configuration: configuration)
        }
    }

    private func getBlocks() -> [BlenderBlockType] {
        return [.header(viewModel: headerViewModel),
                .inputText(viewModel: inputTextViewModel),
                .selectFont(viewModel: selectFontSizeViewModel)]
    }
}
