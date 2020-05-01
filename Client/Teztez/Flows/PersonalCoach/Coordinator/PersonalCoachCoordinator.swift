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
}
