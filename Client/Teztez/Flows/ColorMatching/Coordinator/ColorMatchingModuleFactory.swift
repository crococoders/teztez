//
//  ColorMatchingModuleFactory.swift
//  Teztez
//
//  Created by Adlet on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol ColorMatchingModuleFactory {
    func makeMatchingActivityIntro() -> ActivitiesIntroPresentable
    func makeMatchingConfiguration() -> ColorMatchingConfigurationPresentable
//    func makeMatchingTraining(configuration: ColorMatchingConfiguration) -> ColorMatchingTrainingPresentable
//    func makeMatchingResult(score: Int) -> ColorMatchingResultPresentable
}

extension ModuleFactory: ColorMatchingModuleFactory {
    func makeMatchingActivityIntro() -> ActivitiesIntroPresentable {
        let viewModel = ActivitiesIntroViewModel(type: .colorMatch)
        let viewController = ActivitiesIntroViewController(viewModel: viewModel)
        return viewController
    }

    func makeMatchingConfiguration() -> ColorMatchingConfigurationPresentable {
        let store = ColorMatchingConfigurationStore()
        let viewController = ColorMatchingConfigurationViewController(store: store)
        return viewController
    }

//    func makeMatchingTraining(configuration: ColorMatchingConfiguration) -> ColorMatchingTrainingPresentable {
//        let store = ColorMatchingTrainingStore(configuration: configuration)
//        let viewController = ColorMatchingTrainingViewController(store: store)
//        return viewController
//    }
//
//    func makeMatchingResult(score: Int) -> ColorMatchingResultPresentable {
//        let store = ColorMatchingResultStore(score: score)
//        let viewController = ColorMatchingResultViewController(store: store)
//        return viewController
//    }
}
