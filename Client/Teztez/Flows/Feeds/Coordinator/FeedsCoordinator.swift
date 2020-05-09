//
//  FeedsCoordinator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

final class FeedsCoordinator: ParentCoordinator {
    var onFlowDidFinish: Callback?

    private let coordinatorFactory: CoordinatorFactory
    private let moduleFactory: FeedsModuleFactory

    init(coordinatorFactory: CoordinatorFactory, moduleFactory: FeedsModuleFactory, router: Router) {
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
        super.init(router: router)
    }

    override func start() {
        showFeeds()
    }

    private func showFeeds() {
        var feeds = moduleFactory.makeFeeds()
        feeds.onInformationSelected = { [weak self] details in
            self?.showInformationDetails(details: details)
        }
        feeds.onProfileButtonDidTap = { [weak self] in
            self?.runSettingsFlow()
        }
        router.setRootModule(feeds)
    }

    private func showInformationDetails(details: InformationDetails) {
        var informationDetails = moduleFactory.makeInformationDetails(details: details)
        informationDetails.onCloseButtonDidTap = { [weak self] in
            self?.router.dismissModule()
        }
        router.show(informationDetails, with: .presentInFullScreen(animated: true))
    }

    private func runSettingsFlow() {
        let coordinator = coordinatorFactory.makeSettingsCoordinator(router: router)
        addDependency(coordinator)
        coordinator.onFlowDidFinish = { [weak self, weak coordinator] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.router.popModule()
        }
        coordinator.start()
    }
}
