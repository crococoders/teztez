//
//  BlenderModuleFactory.swift
//  Teztez
//
//  Created by Adlet on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol BlenderModuleFactory {
    func makeBlenderActivityIntro() -> ActivitiesIntroPresentable
    func makeBlenderConfiguration() -> BlenderConfigurationPresentable
    func makeBlenderTextInput(text: String?) -> (container: CoordinatorNavigationController, module: TextInputPresentable)
    func makeBlenderFontSizeChange(fontSize: CGFloat) -> (container: CoordinatorNavigationController, module: FontSizeChangePresentable)
    func makeBlenderConvert(configuration: BlenderConfiguration) -> BlenderConvertPresentable
}

extension ModuleFactory: BlenderModuleFactory {
    func makeBlenderActivityIntro() -> ActivitiesIntroPresentable {
        let viewModel = ActivitiesIntroViewModel(type: .blender)
        let viewController = ActivitiesIntroViewController(viewModel: viewModel)
        return viewController
    }

    func makeBlenderConfiguration() -> BlenderConfigurationPresentable {
        let store = BlenderConfigurationStore()
        let viewController = BlenderConfigurationViewController(store: store)
        return viewController
    }

    func makeBlenderTextInput(text: String?) -> (container: CoordinatorNavigationController, module: TextInputPresentable) {
        let viewController = TextInputViewController(store: TextInputStore())
        let navigaitonController = CoordinatorNavigationController()
        navigaitonController.setViewControllers([viewController], animated: true)
        return (navigaitonController, viewController)
    }

    func makeBlenderFontSizeChange(fontSize: CGFloat) -> (container: CoordinatorNavigationController, module: FontSizeChangePresentable) {
        let store = FontSizeChangeStore(fontSize: fontSize)
        let viewController = FontSizeChangeViewController(store: store)
        let navigaitonController = CoordinatorNavigationController()
        navigaitonController.setViewControllers([viewController], animated: true)
        return (navigaitonController, viewController)
    }

    func makeBlenderConvert(configuration: BlenderConfiguration) -> BlenderConvertPresentable {
        let store = BlenderConvertStore(configuration: configuration)
        let viewController = BlenderConvertViewController(store: store)
        return viewController
    }
}
