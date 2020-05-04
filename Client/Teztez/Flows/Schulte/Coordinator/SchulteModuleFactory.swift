//
//  SchulteModuleFactory.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol SchulteModuleFactory {
    func makeSchulteIntro() -> ActivitiesIntroPresentable
    func makeSchulteConfiguration() -> SchulteConfigurationPresentable
    func makeSchulteGame(configuration: SchulteConfiguration) -> SchulteGamePresentable
    func makeSchulteResult(totalTime: String) -> SchulteResultPresentable
}

extension ModuleFactory: SchulteModuleFactory {
    func makeSchulteIntro() -> ActivitiesIntroPresentable {
        let viewModel = ActivitiesIntroViewModel(type: .schulte)
        let viewController = ActivitiesIntroViewController(viewModel: viewModel)
        return viewController
    }

    func makeSchulteConfiguration() -> SchulteConfigurationPresentable {
        let viewController = SchulteConfigurationViewController(store: SchulteConfigurationStore())
        return viewController
    }

    func makeSchulteGame(configuration: SchulteConfiguration) -> SchulteGamePresentable {
        let store = SchulteGameStore(configuration: configuration)
        let viewController = SchulteGameViewController(store: store)
        return viewController
    }

    func makeSchulteResult(totalTime: String) -> SchulteResultPresentable {
        let store = SchulteResultStore(totalTime: totalTime)
        let viewController = SchulteResultViewController(store: store)
        return viewController
    }
}
