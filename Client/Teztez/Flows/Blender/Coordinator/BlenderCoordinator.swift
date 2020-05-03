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
    private var configuration: BlenderConfiguration?
    private var fonSize: CGFloat?

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
        blenderConfiguration?.onFontSizeChangeDidTap = { [weak self] in
            guard let self = self else { return }
            let fontSize = self.fonSize ?? Constants.defaultFontSize
            self.showFontSizeChange(fontSize: fontSize)
        }
        blenderConfiguration?.onTextInputDidTap = { [weak self] in
            self?.showInpuText(text: nil)
        }
        blenderConfiguration?.onStartButtonDidTap = { [weak self] configuration in
            guard let self = self else { return }
            self.configuration = configuration
            self.showBlenderConvert(configuration: configuration)
        }
        blenderConfiguration?.onContinueButtonDidTap = { [weak self] in
            guard
                let self = self,
                let configuration = self.configuration else { return }
            self.showBlenderConvert(configuration: configuration)
        }
        router.setRootModule(blenderConfiguration)
    }

    private func showInpuText(text: String?) {
        var (container, inputText) = moduleFactory.makeBlenderTextInput(text: text)
        inputText.onCancelButtonDidTap = { [weak self] in
            self?.router.dismissModule()
        }
        inputText.onDoneButtonDidTap = { [weak self] text in
            guard let self = self else { return }
            self.blenderConfiguration?.setUserText(text)
            self.router.dismissModule()
        }
        router.show(container, with: .presentInSheet(dismissable: false))
    }

    private func showFontSizeChange(fontSize: CGFloat) {
        var (container, fontSizeChange) = moduleFactory.makeBlenderFontSizeChange(fontSize: fontSize)
        fontSizeChange.onCancelButtonDidTap = { [weak self] in
            self?.router.dismissModule()
        }

        fontSizeChange.onFontSizeDidSelect = { [weak self] fontSize in
            guard let self = self else { return }
            self.fonSize = fontSize
            self.blenderConfiguration?.setUserFontSize(fontSize)
            self.router.dismissModule()
        }
        router.show(container, with: .presentInSheet(dismissable: false))
    }

    private func showBlenderConvert(configuration: BlenderConfiguration) {
        var blenderConvert = moduleFactory.makeBlenderConvert(configuration: configuration)
        blenderConvert.onBackButtonDidTap = { [weak self] in
            guard let self = self else { return }
            self.blenderConfiguration?.setupBlenderPause()
            self.router.popModule()
        }
        router.show(blenderConvert, with: .push)
    }
}
