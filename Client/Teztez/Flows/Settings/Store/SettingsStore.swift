//
//  SettingsStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 09/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation
import Models

final class SettingsStore {
    enum Action {
        case didViewLoad
        case didTapPrivacyPolicy
        case didTapTermsOfConditions
    }

    enum State {
        case initial(sections: [SettingsSectionType])
        case navigateToPrivacyPolicy
        case navigateToTermsOfConditions
    }

    @Published private(set) var state: State?
    private var sections: [SettingsSectionType] = []

    func dispatch(action: Action) {
        switch action {
        case .didViewLoad:
            compileInitialSections()
            state = .initial(sections: sections)
        case .didTapPrivacyPolicy:
            state = .navigateToPrivacyPolicy
        case .didTapTermsOfConditions:
            state = .navigateToTermsOfConditions
        }
    }

    private func compileInitialSections() {
        sections = [.appereance(rows: [.web(viewModel: SettingsWebViewModel(title: "Appereance", documentURLString: "")),
                                       .web(viewModel: SettingsWebViewModel(title: "App Icon", documentURLString: ""))]),
                    .appereance(rows: [.web(viewModel: SettingsWebViewModel(title: "Press to Pay Respect", documentURLString: ""))]),
                    .document(rows: [.web(viewModel: SettingsWebViewModel(title: "Terms of Service", documentURLString: "")),
                                     .web(viewModel: SettingsWebViewModel(title: "Privacy Policy", documentURLString: ""))])]
        guard
            let username = UserSession.shared.username,
            let name = UserSession.shared.name else { return }
        sections.insert(.profile(rows: [.profile(viewModel: SettingsProfileViewModel(name: name, username: username))]), at: 0)
    }
}
