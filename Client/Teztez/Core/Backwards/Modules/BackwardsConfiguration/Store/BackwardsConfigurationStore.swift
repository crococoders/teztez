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
    static let defaultText = "Google began in March 1996 as a research project by Larry Page and Sergey Brin, both PhD students at Stanford University working on the Stanford Digital Library Project (SDLP). The goal of the SDLP was \"to develop the enabling technologies for a single, integrated and universal digital library\" and was funded through the National Science Foundation among other federal agencies. In search for a dissertation theme, Page considered—among other things—exploring the mathematical properties of the World Wide Web, understanding its link structure as a huge graph. His supervisor Terry Winograd encouraged him to pick this idea (which Page later recalled as \"the best advice I ever got\") and Page focused on the problem of finding out which web pages link to a given page, considering the number and nature of such backlinks to be valuable information about that page (with the role of citations in academic publishing in mind).In his research project, nicknamed \"BackRub\", he was soon joined by Sergey Brin, a fellow Stanford Ph.D. student supported by a National Science Foundation Graduate Fellowship. Brin was already a close friend, whom Page had first met in the summer of 1995 in a group of potential new students which Brin had volunteered to show around the campus. Page's web crawler began exploring the web in March 1996, setting out from Page's own Stanford home page as its only starting point. To convert the backlink data that it gathered into a measure of importance for a given web page, Brin and Page developed the PageRank algorithm. Analyzing BackRub's output which, for a given URL, consisted of a list of backlinks ranked by importance it occurred to them that a search engine based on PageRank would produce better results than existing techniques (existing search engines at the time essentially ranked results according to how many times the search term appeared on a page)."
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
