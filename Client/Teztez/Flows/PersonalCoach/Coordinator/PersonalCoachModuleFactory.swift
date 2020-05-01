//
//  PersonalCoachModuleFactory.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol PersonalCoachModuleFactory {
    func makePersonalCoachConfiguration() -> PersonalCoachPresentable
    // TODO: Create Coordinator for InputTextViewController and delete this func
    func makePersonalCoachTextInput(text: String?) -> (container: CoordinatorNavigationController, module: TextInputPresentable)
}

extension ModuleFactory: PersonalCoachModuleFactory {
    func makePersonalCoachConfiguration() -> PersonalCoachPresentable {
        let viewController = PersonalCoachViewController(store: PersonalCoachStore())
        return viewController
    }

    func makePersonalCoachTextInput(text: String?) -> (container: CoordinatorNavigationController, module: TextInputPresentable) {
        let viewController = TextInputViewController(store: TextInputStore())
        let navigaitonController = CoordinatorNavigationController()
        navigaitonController.setViewControllers([viewController], animated: true)
        return (navigaitonController, viewController)
    }
}
