//
//  AuthCoordinator.swift
//  Teztez
//
//  Created by Adlet on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol AuthCoordinatorOutput: class {
    var onFlowDidFinish: Callback? { get set }
}

final class AuthCoordinator: Coordinator, AuthCoordinatorOutput {
    var onFlowDidFinish: Callback?

    private let moduleFactory: AuthModuleFactory
    private let router: Router

    init(moduleFactory: AuthModuleFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.router = router
    }

    func start() {
        showAuth()
    }

    private func showAuth() {
        var auth = moduleFactory.makeAuth()
        auth.onRegisterDidFinish = { [weak self] in
            self?.onFlowDidFinish?()
        }
        router.setRootModule(auth, hideBar: true)
    }
}
