//
//  ThirdPartiesAppDelegateConfigurator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import IQKeyboardManagerSwift
import UIKit

final class ThirdPartiesAppDelegateConfigurator: AppDelegateConfigurator {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupKeyboardManager()
        return true
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
