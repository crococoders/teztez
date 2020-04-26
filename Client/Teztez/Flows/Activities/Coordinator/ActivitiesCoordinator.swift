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

    init(moduleFactory: ActivitiesModuleFactory, router: Router) {
        self.moduleFactory = moduleFactory
        super.init(router: router)
    }

    override func start() {
        showActivites()
    }

    private func showActivites() {
        let activities = moduleFactory.makeActivities()
        router.setRootModule(activities)
    }
}
