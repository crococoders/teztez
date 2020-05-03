//
//  ActivitiesCoordinator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

final class ActivitiesCoordinator: ParentCoordinator {
    private let moduleFactory: ActivitiesModuleFactory
    private let coordinatorFactory: CoordinatorFactory

    init(moduleFactory: ActivitiesModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start() {
        showActivites()
    }

    private func showActivites() {
        var activities = moduleFactory.makeActivities()
        activities.onItemDidSelect = { [weak self] itemType in
            self?.runFlow(by: itemType)
        }
        router.setRootModule(activities)
    }

    private func runFlow(by itemType: ActivitiesItemType) {
        switch itemType {
        case .coach:
            runPersoalCoachFlow()
        case .backwards:
            runBackwardsFlow()
        case .blender:
            runBlenderFlow()
        default:
            break
        }
    }

    private func runPersoalCoachFlow() {
        let (coordinator, module) = coordinatorFactory.makePersonalCoachCoordinator()
        coordinator.onFlowDidFinish = { [weak self, weak coordinator] in
            guard let coordinator = coordinator else { return }
            self?.dismiss(child: coordinator)
        }
        show((coordinator, module), with: .presentInFullScreen(animated: true))
    }

    private func runBackwardsFlow() {
        let (coordinator, module) = coordinatorFactory.makeBackwardsCoordinator()
        coordinator.onFlowDidFinish = { [weak self, weak coordinator] in
            guard let coordinator = coordinator else { return }
            self?.dismiss(child: coordinator)
        }
        show((coordinator, module), with: .presentInFullScreen(animated: true))
    }

    private func runBlenderFlow() {
        let (coordinator, module) = coordinatorFactory.makeBlenderCoordinator()
        coordinator.onFlowDidFinish = { [weak self, weak coordinator] in
            guard let coordinator = coordinator else { return }
            self?.dismiss(child: coordinator)
        }
        show((coordinator, module), with: .presentInFullScreen(animated: true))
    }
}
