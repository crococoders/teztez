//
//  StartupAppDelegateConfigurator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class StartupAppDelegateConfigurator: AppDelegateConfigurator {
    private var rootController: CoordinatorNavigationController? {
        return UIApplication.shared.windows.first?.rootViewController as? CoordinatorNavigationController
    }

    private lazy var applicationCoordinator: Coordinator? = {
        guard let rootController = rootController else { return nil }
        let instructor = ApplicationLaunchInstructor()
        let router = Router(rootController: rootController)
        let factory = CoordinatorFactory()
        return ApplicationCoordinator(instructor: instructor, router: router, coordinatorFactory: factory)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if UserDefaultsStorage.isFirstLaunch {
            UserDefaultsStorage.isFirstLaunch = false
        }

        applicationCoordinator?.start()
        return true
    }
}

private extension UserDefaultsStorage {
    @UserDefaultsEntry("isFirstLaunch", defaultValue: true)
    static var isFirstLaunch: Bool
}
