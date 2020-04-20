//
//  StartupAppDelegateConfigurator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class StartupAppDelegateConfigurator: AppDelegateConfigurator {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if UserDefaultsStorage.isFirstLaunch {
            UserDefaultsStorage.isFirstLaunch = false
        }
        return true
    }
}

private extension UserDefaultsStorage {
    @UserDefaultsEntry("isFirstLaunch", defaultValue: true)
    static var isFirstLaunch: Bool
}
