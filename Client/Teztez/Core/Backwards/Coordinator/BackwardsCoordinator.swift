//
//  BackwordsCoordinator.swift
//  Teztez
//
//  Created by Adlet on 5/2/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol BackwardsCoordinatorOutput: class {
    var onFlowDidFinish: Callback? { get set }
}

private enum Constants {
    static let defaultFontSize: CGFloat = 15
}

final class BackwardsCoordinator: Coordinator, BackwardsCoordinatorOutput {
    var onFlowDidFinish: Callback?

    private let moduleFactory: BackwardsModuleFactory
    private let router: Router
    private var backwardsConfiguration: BackwardsConfigurationPresentable?
    private var configuration: BackwardsConfiguration?
    private var fonSize: CGFloat?

    init(moduleFactory: BackwardsModuleFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.router = router
    }

    func start() {
        showBackwordActivityIntro()
    }

    private func showBackwordActivityIntro() {
        var activityIntro = moduleFactory.makeBackwardsActivityIntro()
        activityIntro.onCloseButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }

        activityIntro.onNextButtonDidTap = { [weak self] in
            self?.showBackwardsConfiguration()
        }
        router.setRootModule(activityIntro)
    }

    private func showBackwardsConfiguration() {
        backwardsConfiguration = moduleFactory.makeBackwardsConfiguration()
        backwardsConfiguration?.onCloseButtonDidTap = { [weak self] in
            self?.onFlowDidFinish?()
        }

        backwardsConfiguration?.onFontSizeChangeDidTap = { [weak self] in
            guard let self = self else { return }
            let fontSize = self.fonSize ?? Constants.defaultFontSize

            self.showFontSizeChange(fontSize: fontSize)
        }

        backwardsConfiguration?.onTextInputDidTap = { [weak self] in
            self?.showInpuText(text: nil)
        }

        backwardsConfiguration?.onStartButtonDidTap = { [weak self] configuration in
            guard let self = self else { return }
            self.configuration = configuration
            self.showBackwardsConvert(configuration: configuration)
        }

        backwardsConfiguration?.onContinueButtonDidTap = { [weak self] in
            guard
                let self = self,
                let configuration = self.configuration else { return }
            self.showBackwardsConvert(configuration: configuration)
        }

        router.setRootModule(backwardsConfiguration)
    }

    private func showInpuText(text: String?) {
        var (container, inputText) = moduleFactory.makeBackwardsTextInput(text: text)
        inputText.onCancelButtonDidTap = { [weak self] in
            self?.router.dismissModule()
        }

        inputText.onDoneButtonDidTap = { [weak self] text in
            guard let self = self else { return }
            self.backwardsConfiguration?.setUserText(text)
            self.router.dismissModule()
        }
        router.show(container, with: .presentInSheet(dismissable: false))
    }

    private func showFontSizeChange(fontSize: CGFloat) {
        var (container, fontSizeChange) = moduleFactory.makeBackwardsFontSizeChange(fontSize: fontSize)
        fontSizeChange.onCancelButtonDidTap = { [weak self] in
            self?.router.dismissModule()
        }

        fontSizeChange.onFontSizeDidSelect = { [weak self] fontSize in
            guard let self = self else { return }
            self.fonSize = fontSize
            self.backwardsConfiguration?.setUserFontSize(fontSize)
            self.router.dismissModule()
        }
        router.show(container, with: .presentInSheet(dismissable: false))
    }

    private func showBackwardsConvert(configuration: BackwardsConfiguration) {
        var backwardConvert = moduleFactory.makeBackwardsConvertText(configuration: configuration)
        backwardConvert.onBackButtonDidTap = { [weak self] in
            guard let self = self else { return }
            self.backwardsConfiguration?.setupBackwardsPause()
            self.router.popModule()
        }
        router.show(backwardConvert, with: .push)
    }
}
