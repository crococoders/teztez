//
//  SchulteCoordinator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol SchulteCoordinatorOutput: class {
    var onFlowDidFinish: Callback? { get set }
}

final class SchulteCoordinator: Coordinator, SchulteCoordinatorOutput {
    var onFlowDidFinish: Callback?

    private let moduleFactory: SchulteModuleFactory
    private let router: Router
    private var configurationPresentable: SchulteConfigurationPresentable?
    private var configuration: SchulteConfiguration?

    init(moduleFactory: SchulteModuleFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.router = router
    }

    func start() {
        showIntro()
    }

    private func showIntro() {
        var introPresentable = moduleFactory.makeSchulteIntro()
        introPresentable.onNextButtonDidTap = { [weak self] in
            self?.showConfiguration()
        }
        introPresentable.onCloseButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        router.setRootModule(introPresentable)
    }

    private func showConfiguration() {
        configurationPresentable = moduleFactory.makeSchulteConfiguration()
        configurationPresentable?.onCloseButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        configurationPresentable?.onNextButtonDidTap = { [weak self] configuration in
            self?.showTraining(configuration: configuration)
        }
        configurationPresentable?.onContinueButtonDidTap = { [weak self] in
            guard let configuration = self?.configuration else { return }
            self?.showTraining(configuration: configuration)
        }
        router.setRootModule(configurationPresentable)
    }

    private func showTraining(configuration: SchulteConfiguration) {
        var trainingPresentable = moduleFactory.makeSchulteTraining(configuration: configuration)
        trainingPresentable.onBackButtonDidTap = { [weak self] configuration in
            guard let self = self else { return }
            self.configuration = configuration
            self.configurationPresentable?.enablePauseMode()
            self.router.popModule()
        }
        trainingPresentable.onTrainingDidFinish = { [weak self] totalTime in
            self?.showResult(totalTime: totalTime)
        }
        router.show(trainingPresentable, with: .push)
    }

    private func showResult(totalTime: String) {
        var result = moduleFactory.makeSchulteResult(totalTime: totalTime)
        result.onHomeButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        result.onRestartButtonDidTap = { [weak self] in
            self?.showConfiguration()
        }
        router.setRootModule(result)
    }
}
