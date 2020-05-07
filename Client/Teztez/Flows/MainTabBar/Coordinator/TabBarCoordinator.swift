//
//  TabBarCoordinator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

final class TabBarCoordinator: ParentCoordinator {
    private let coordinatorFactory: CoordinatorFactory
    private var tabBarPresentable: TabBarPresentable

    init(tabBarPresentable: TabBarPresentable, router: Router, coordinatorFactory: CoordinatorFactory) {
        self.tabBarPresentable = tabBarPresentable
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start() {
        router.setRootModule(tabBarPresentable, hideBar: true)
        tabBarPresentable.onViewDidLoad = runFeedsFlow()
        tabBarPresentable.onFeedsTabDidSelect = runFeedsFlow()
        tabBarPresentable.onActivitiesTabDidSelect = runActivitiesFlow()
    }

    private func runFeedsFlow() -> ((CoordinatorNavigationController) -> Void) {
        return { [weak self] navigationController in
            guard
                let self = self,
                navigationController.viewControllers.isEmpty else { return }
            let feedsCoordinator = self.coordinatorFactory.makeFeedsCoordinator(navigationController: navigationController)
            self.addDependency(feedsCoordinator)
            feedsCoordinator.start()
        }
    }

    private func runActivitiesFlow() -> ((CoordinatorNavigationController) -> Void) {
        return { [weak self] navigationController in
            guard
                let self = self,
                navigationController.viewControllers.isEmpty else { return }
            let activitiesCooridnator = self.coordinatorFactory.makeActivitiesCoordinator(navigationController: navigationController)
            self.addDependency(activitiesCooridnator)
            activitiesCooridnator.start()
        }
    }
}
