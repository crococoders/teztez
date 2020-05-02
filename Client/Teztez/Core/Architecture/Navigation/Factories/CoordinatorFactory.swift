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

    func makeActivitiesCoordiantor(navigationController: CoordinatorNavigationController) -> Coordinator {
        let coordinator = ActivitiesCoordinator(moduleFactory: ModuleFactory.shared,
                                                coordinatorFactory: CoordinatorFactory(),
                                                router: Router(rootController: navigationController))
        return coordinator
    }

    func makePersonalCoachCoordinator() -> (coordinator: Coordinator & PersonalCoachCoordinatorOutput, module: Presentable) {
        let rootController = CoordinatorNavigationController()
        let coordinator = PersonalCoachCoordinator(moduleFactory: ModuleFactory.shared,
                                                   router: Router(rootController: rootController))
        return (coordinator, rootController)
    }
}
