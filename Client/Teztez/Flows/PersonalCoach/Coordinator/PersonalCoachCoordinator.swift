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

final class PersonalCoachCoordinator: Coordinator, PersonalCoachCoordinatorOutput {
    var onFlowDidFinish: Callback?

    private let moduleFactory: PersonalCoachModuleFactory
    private let router: Router
    private var configuration: PersonalCoachPresentable?
    private var currentWordIndex: Int?

    init(moduleFactory: PersonalCoachModuleFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.router = router
    }

    func start() {
        showConfiguration()
    }

    private func showConfiguration() {
        configuration = moduleFactory.makePersonalCoachConfiguration()
        configuration?.onTextInputDidTap = { [weak self] in
            self?.showInpuText(text: nil)
        }
        configuration?.onCloseButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }
        configuration?.onStartButtonDidTap = { [weak self] configuration in
            self?.showTraining(configuration: configuration)
        }
        router.setRootModule(configuration)
    }

    private func showInpuText(text: String?) {
        var (container, inputText) = moduleFactory.makePersonalCoachTextInput(text: text)
        inputText.onCancelButtonDidTap = { [weak self] in
            self?.router.dismissModule()
        }
        inputText.onDoneButtonDidTap = { [weak self] text in
            self?.configuration?.setUserText(text)
            self?.router.dismissModule()
        }
        router.show(container, with: .presentInSheet(dismissable: false))
    }

    private func showTraining(configuration: PersonalCoachConfiguration) {
        var training = moduleFactory.makePersonalCoachTraining(configuration: configuration)
        training.onBackButtonDidTap = { [weak self] currentWordIndex in
            guard let self = self else { return }
            self.currentWordIndex = currentWordIndex
            self.router.popModule()
        }
        router.show(training, with: .push)
    }
}
