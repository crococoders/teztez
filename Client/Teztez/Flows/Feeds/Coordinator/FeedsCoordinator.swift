//
//  FeedsCoordinator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

final class FeedsCoordinator: Coordinator, SuggestActivityCoordinatorOutput {
    var onFlowDidFinish: Callback?

    private let moduleFactory: FeedsModuleFactory
    private let router: Router

    init(moduleFactory: FeedsModuleFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.router = router
    }

    func start() {
        showFeeds()
    }

    private func showFeeds() {
        let feeds = moduleFactory.makeFeeds()
        router.setRootModule(feeds)
    }
}
