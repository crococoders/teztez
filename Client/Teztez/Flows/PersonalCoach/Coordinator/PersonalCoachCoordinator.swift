//
//  PersonalCoachCoordinator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol PersonalCoachCoordinatorOutput: class {
    var onFlowDidFinish: Callback? { get set }
}
//TODO: Rename all presentable variables
final class PersonalCoachCoordinator: Coordinator, PersonalCoachCoordinatorOutput {
    var onFlowDidFinish: Callback?

    private let moduleFactory: PersonalCoachModuleFactory
    private let router: Router
    private var configurationPresentable: PersonalCoachPresentable?
    private var configuration: PersonalCoachConfiguration?

    init(moduleFactory: PersonalCoachModuleFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.router = router
    }

    func start() {
        showConfiguration()
    }

    private func showConfiguration() {
        configurationPresentable = moduleFactory.makePersonalCoachConfiguration()
        configurationPresentable?.onTextInputDidTap = { [weak self] in
            self?.showInpuText(text: nil)
        }
        configurationPresentable?.onCloseButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        configurationPresentable?.onStartButtonDidTap = { [weak self] configuration in
            guard let self = self else { return }
            self.configuration = configuration
            self.showTraining(configuration: configuration)
        }
        configurationPresentable?.onContinueButtonDidTap = { [weak self] in
            guard
                let self = self,
                let configuration = self.configuration else { return }
            self.showTraining(configuration: configuration)
        }
        router.setRootModule(configurationPresentable)
    }

    private func showInpuText(text: String?) {
        var (container, inputText) = moduleFactory.makePersonalCoachTextInput(text: text)
        inputText.onCancelButtonDidTap = { [weak self] in
            self?.router.dismissModule()
        }
        inputText.onDoneButtonDidTap = { [weak self] text in
            self?.configurationPresentable?.setUserText(text)
            self?.router.dismissModule()
        }
        router.show(container, with: .presentInSheet(dismissable: false))
    }

    private func showTraining(configuration: PersonalCoachConfiguration) {
        var training = moduleFactory.makePersonalCoachTraining(configuration: configuration)
        training.onBackButtonDidTap = { [weak self] currentWordIndex in
            guard let self = self else { return }
            self.configuration?.startWordIndex = currentWordIndex
            self.configurationPresentable?.enablePauseMode()
            self.router.popModule()
        }
        router.show(training, with: .push)
    }
}
