//
//  BaseCoordinator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

public typealias Flow = (coordinator: Coordinator, module: Presentable?)

public class ParentCoordinator: Coordinator {
    public private(set) var childCoordinators: [Coordinator] = []
    public var router: Router

    init(router: Router) {
        self.router = router
    }

    public func start() {}

    public func show(_ flow: Flow, with transitionType: TransitionType) {
        addDependency(flow.coordinator)
        flow.coordinator.start()
        router.show(flow.module, with: transitionType)
    }

    public func dismiss(child coordinator: Coordinator?) {
        router.dismissModule()
        removeDependency(coordinator)
    }

    public func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }

    public func removeDependency(_ coordinator: Coordinator?) {
        guard !childCoordinators.isEmpty,
            let coordinator = coordinator else { return }
        if let coordinator = coordinator as? ParentCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter { $0 !== coordinator }
                .forEach { coordinator.removeDependency($0) }
        }
        childCoordinators.removeAll { $0 === coordinator }
    }

    public func cleanChildCoordinators() {
        childCoordinators.forEach { removeDependency($0) }
    }
}
