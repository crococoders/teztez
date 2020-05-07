//
//  SuggestActivityCoordinator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol SuggestActivityCoordinatorOutput: class {
    var onFlowDidFinish: Callback? { get set }
}

final class SuggestActivityCoordinator: Coordinator, SuggestActivityCoordinatorOutput {
    var onFlowDidFinish: Callback?

    private let moduleFactory: SuggestActivityModuleFactory
    private let router: Router

    init(moduleFactory: SuggestActivityModuleFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.router = router
    }

    func start() {
        showSuggestActivity()
    }

    private func showSuggestActivity() {
        var suggestActivity = moduleFactory.makeSuggestActivity()
        suggestActivity.onCancelButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        suggestActivity.onSendButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        router.setRootModule(suggestActivity)
    }
}
