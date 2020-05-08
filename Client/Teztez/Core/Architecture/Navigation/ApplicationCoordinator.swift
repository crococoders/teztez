//
//  ApplicationCoordinator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

final class ApplicationCoordinator: ParentCoordinator {
    private let instructor: ApplicationLaunchInstructor
    private let coordinatorFactory: CoordinatorFactory

    init(instructor: ApplicationLaunchInstructor,
         router: Router,
         coordinatorFactory: CoordinatorFactory) {
        self.instructor = instructor
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start() {
        switch instructor.flow {
        case .main:
            runMainTabBarFlow()
        case .auth:
            runAuthFlow()
        }
    }

    private func runMainTabBarFlow() {
        let coordinator = coordinatorFactory.makeMainTabBarCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }

    private func runAuthFlow() {
        let coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
        addDependency(coordinator)
        coordinator.onFlowDidFinish = { [weak self, weak coordinator] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.runMainTabBarFlow()
        }
        coordinator.start()
    }
}
