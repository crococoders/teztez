//
//  BackwardsModuleFactory.swift
//  Teztez
//
//  Created by Adlet on 5/2/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol BackwardsModuleFactory {
    func makeBackwardsActivityIntro() -> ActivitiesIntroPresentable
    func makeBackwardsConvertText(configuration: Configuration) -> BackwardsConvertTextPresentable
    func makeBackwardsConfiguration() -> BackwardsConfigurationPresentable
    func makeBackwardsTextInput(text: String?) -> (container: CoordinatorNavigationController, module: TextInputPresentable)
    func makeBackwardsFontSizeChange(fontSize: CGFloat) -> (container: CoordinatorNavigationController, module: FontSizeChangePresentable)
}

extension ModuleFactory: BackwardsModuleFactory {
    func makeBackwardsActivityIntro() -> ActivitiesIntroPresentable {
        let viewModel = ActivitiesIntroViewModel(type: .backwards)
        let viewController = ActivitiesIntroViewController(viewModel: viewModel)
        return viewController
    }

    func makeBackwardsConfiguration() -> BackwardsConfigurationPresentable {
        let viewController = BackwardsConfigurationViewController(store: BackwardsConfigurationStore())
        return viewController
    }

    func makeBackwardsTextInput(text: String?) -> (container: CoordinatorNavigationController, module: TextInputPresentable) {
        let viewController = TextInputViewController(store: TextInputStore())
        let navigaitonController = CoordinatorNavigationController()
        navigaitonController.setViewControllers([viewController], animated: true)
        return (navigaitonController, viewController)
    }

    func makeBackwardsConvertText(configuration: Configuration) -> BackwardsConvertTextPresentable {
        let store = BackwardsConvertTextStore(configuration: configuration)
        let viewController = BackwardsConvertTextViewController(store: store)
        return viewController
    }

    func makeBackwardsFontSizeChange(fontSize: CGFloat) -> (container: CoordinatorNavigationController, module: FontSizeChangePresentable) {
        let store = FontSizeChangeStore(fontSize: fontSize)
        let viewController = FontSizeChangeViewController(store: store)
        let navigaitonController = CoordinatorNavigationController()
        navigaitonController.setViewControllers([viewController], animated: true)
        return (navigaitonController, viewController)
    }
}
