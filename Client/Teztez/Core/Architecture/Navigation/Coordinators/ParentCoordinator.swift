//
//  BaseCoordinator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

typealias Flow = (coordinator: Coordinator, module: Presentable?)

class ParentCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var router: Router

    init(router: Router) {
        self.router = router
    }

    func start() {}

    func show(_ flow: Flow, with transitionType: TransitionType) {
        addDependency(flow.coordinator)
        flow.coordinator.start()
        router.show(flow.module, with: transitionType)
    }

    func dismiss(child coordinator: Coordinator?) {
        router.dismissModule()
        removeDependency(coordinator)
    }

    func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard !childCoordinators.isEmpty,
            let coordinator = coordinator else { return }
        if let coordinator = coordinator as? ParentCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter { $0 !== coordinator }
                .forEach { coordinator.removeDependency($0) }
        }
        childCoordinators.removeAll { $0 === coordinator }
    }

    func cleanChildCoordinators() {
        childCoordinators.forEach { removeDependency($0) }
    }
}
