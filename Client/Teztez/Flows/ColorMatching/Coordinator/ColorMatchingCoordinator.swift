//
//  ColorMatchingCoordinator.swift
//  Teztez
//
//  Created by Adlet on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol ColorMatchingCoordinatorOutput: class {
    var onFlowDidFinish: Callback? { get set }
}

final class ColorMatchingCoordinator: Coordinator, ColorMatchingCoordinatorOutput {
    var onFlowDidFinish: Callback?

    private let moduleFactory: ColorMatchingModuleFactory
    private let router: Router
    private var matchingConfiguration: ColorMatchingConfigurationPresentable?
    private var configuration: ColorMatchingConfiguration?

    init(moduleFactory: ColorMatchingModuleFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.router = router
    }

    func start() {
        showMatchingActivityIntro()
    }

    private func showMatchingActivityIntro() {
        var activityIntro = moduleFactory.makeMatchingActivityIntro()
        activityIntro.onCloseButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        activityIntro.onNextButtonDidTap = { [weak self] in
            self?.showMatchingConfiguration()
        }
        router.setRootModule(activityIntro)
    }

    private func showMatchingConfiguration() {
        matchingConfiguration = moduleFactory.makeMatchingConfiguration()
        matchingConfiguration?.onCloseButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        matchingConfiguration?.onStartButtonDidTap = { [weak self] _ in
            guard let self = self else { return }
            // self.showMatchingTraining(with: configuration)
        }
        matchingConfiguration?.onContinueButtonDidTap = { [weak self] in
            guard let self = self, let configuration = self.configuration else { return }
            // self.showMatchingTraining(with: configuration)
        }
        router.setRootModule(matchingConfiguration)
    }

//    private func showMatchingTraining(with configuration: ColorMatchingConfiguration) {
//        var matchingTraining = moduleFactory.makeMatchingTraining(configuration: configuration)
//        matchingTraining.onBackButtonDidTap = { [weak self] configuration in
//            guard let self = self else { return }
//            self.configuration = configuration
//            self.matchingConfiguration?.enablePauseMode()
//            self.router.popModule()
//        }
//        matchingTraining.onTrainingDidFinish = { [weak self] score in
//            self?.showResult(score: score)
//        }
//        router.show(matchingTraining, with: .push)
//    }
//
//    private func showResult(score: Int) {
//        var result = moduleFactory.makeMatchingResult(score: score)
//        result.onHomeButtonDidTap = { [weak self] in
//            self?.onFlowDidFinish?()
//        }
//        result.onRestartButtonDidTap = { [weak self] in
//            self?.showMatchingConfiguration()
//        }
//        router.setRootModule(result)
//    }
}
