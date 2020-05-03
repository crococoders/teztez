//
//  BlenderCoordinator.swift
//  Teztez
//
//  Created by Adlet on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol BlenderCoordinatorOutput: class {
    var onFlowDidFinish: Callback? { get set }
}

private enum Constants {
    static let defaultFontSize: CGFloat = 15
}

final class BlenderCoordinator: Coordinator, BlenderCoordinatorOutput {
    var onFlowDidFinish: Callback?

    private let moduleFactory: BlenderModuleFactory
    private let router: Router
    private var blenderConfiguration: BlenderConfigurationPresentable?

    init(moduleFactory: BlenderModuleFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.router = router
    }

    func start() {
        showBlenderActivityIntro()
    }

    private func showBlenderActivityIntro() {
        var activityIntro = moduleFactory.makeBlenderActivityIntro()
        activityIntro.onCloseButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        activityIntro.onNextButtonDidTap = { [weak self] in
            self?.showBlenderConfiguration()
        }
        router.setRootModule(activityIntro)
    }

    private func showBlenderConfiguration() {
        blenderConfiguration = moduleFactory.makeBlenderConfiguration()
        blenderConfiguration?.onCloseButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        router.setRootModule(blenderConfiguration)
    }
}
