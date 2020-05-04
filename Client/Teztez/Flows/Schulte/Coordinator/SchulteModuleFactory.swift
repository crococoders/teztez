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
    func makeSchulteTraining(configuration: SchulteConfiguration) -> SchulteTrainingPresentable
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

    func makeSchulteTraining(configuration: SchulteConfiguration) -> SchulteTrainingPresentable {
        let store = SchulteTrainingStore(configuration: configuration)
        let viewController = SchulteTrainingViewController(store: store)
        return viewController
    }

    func makeSchulteResult(totalTime: String) -> SchulteResultPresentable {
        let store = SchulteResultStore(totalTime: totalTime)
        let viewController = SchulteResultViewController(store: store)
        return viewController
    }
}
