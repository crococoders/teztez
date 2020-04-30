//
//  ThirdPartiesSceneDelegateConfigurator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/20/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import IQKeyboardManagerSwift
import UIKit

class ThirdPartiesSceneDelegateConfigurator: SceneDelegateConfigurator {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupKeyboardManager()
    }

    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = R.string.localizable.buttonDone()
        IQKeyboardManager.shared.toolbarTintColor = .accentBlue
        IQKeyboardManager.shared.toolbarBarTintColor = .systemGray
    }
}
