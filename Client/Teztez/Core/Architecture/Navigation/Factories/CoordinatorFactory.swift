//
//  CoordinatorFactory.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

final class CoordinatorFactory {
    func makeMainTabBarCoordinator(router: Router) -> Coordinator {
        let tabBarController = TabBarController()
        let coordinator = TabBarCoordinator(tabBarPresentable: tabBarController,
                                            router: router,
                                            coordinatorFactory: CoordinatorFactory())
        return coordinator
    }

    public func makeAuthCoordinator(router: Router) -> Coordinator & AuthCoordinatorOutput {
        let coordinator = AuthCoordinator(moduleFactory: ModuleFactory.shared,
                                          router: router)
        return coordinator
    }

    func makeActivitiesCoordinator(navigationController: CoordinatorNavigationController) -> Coordinator {
        let coordinator = ActivitiesCoordinator(moduleFactory: ModuleFactory.shared,
                                                coordinatorFactory: CoordinatorFactory(),
                                                router: Router(rootController: navigationController))
        return coordinator
    }

    func makeFeedsCoordinator(navigationController: CoordinatorNavigationController) -> Coordinator {
        let coordinator = FeedsCoordinator(coordinatorFactory: CoordinatorFactory(),
                                           moduleFactory: ModuleFactory.shared,
                                           router: Router(rootController: navigationController))
        return coordinator
    }

    func makePersonalCoachCoordinator() -> (coordinator: Coordinator & PersonalCoachCoordinatorOutput, module: Presentable) {
        let rootController = CoordinatorNavigationController()
        let coordinator = PersonalCoachCoordinator(moduleFactory: ModuleFactory.shared,
                                                   router: Router(rootController: rootController))
        return (coordinator, rootController)
    }

    func makeSchulteCoordinator() -> (coordinator: Coordinator & SchulteCoordinatorOutput, module: Presentable) {
        let rootController = CoordinatorNavigationController()
        let coordinator = SchulteCoordinator(moduleFactory: ModuleFactory.shared,
                                             router: Router(rootController: rootController))
        return (coordinator, rootController)
    }

    func makeBackwardsCoordinator() -> (coordinator: Coordinator & BackwardsCoordinatorOutput, module: Presentable) {
        let rootCoontroller = CoordinatorNavigationController()
        let coordinator = BackwardsCoordinator(moduleFactory: ModuleFactory.shared,
                                               router: Router(rootController: rootCoontroller))
        return (coordinator, rootCoontroller)
    }

    func makeBlenderCoordinator() -> (coordinator: Coordinator & BlenderCoordinatorOutput, module: Presentable) {
        let rootCoontroller = CoordinatorNavigationController()
        let coordinator = BlenderCoordinator(moduleFactory: ModuleFactory.shared,
                                             router: Router(rootController: rootCoontroller))
        return (coordinator, rootCoontroller)
    }

    func makeSuggestActivityCoordinator() -> (coordinator: Coordinator & SuggestActivityCoordinatorOutput, module: Presentable) {
        let rootCoontroller = CoordinatorNavigationController()
        let coordinator = SuggestActivityCoordinator(moduleFactory: ModuleFactory.shared,
                                                     router: Router(rootController: rootCoontroller))
        return (coordinator, rootCoontroller)
    }

    func makeSettingsCoordinator(router: Router) -> Coordinator & SettingsCoordinatorOutput {
        let coordinator = SettingsCoordinator(moduleFactory: ModuleFactory.shared, router: router)
        return coordinator
    }
}
