//
//  SettingsCoordiantor.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol SettingsCoordinatorOutput: class {
    var onFlowDidFinish: Callback? { get set }
}

final class SettingsCoordinator: Coordinator, SettingsCoordinatorOutput {
    var onFlowDidFinish: Callback?

    private let moduleFactory: SettingsModuleFactory
    private let router: Router

    init(moduleFactory: SettingsModuleFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.router = router
    }

    func start() {
        showSettings()
    }

    private func showSettings() {
        var settings = moduleFactory.makeSettings()
        settings.onBackButtonTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        router.show(settings, with: .push)
    }
}
