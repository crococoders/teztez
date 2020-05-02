//
//  WindowSetupCommand.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/20/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class StartupSceneDelegateConfigurator: SceneDelegateConfigurator {
    var window: UIWindow?

    private lazy var applicationCoordinator: Coordinator? = {
        guard let rootController = window?.rootViewController as? CoordinatorNavigationController else { return nil }
        let instructor = ApplicationLaunchInstructor()
        let router = Router(rootController: rootController)
        let factory = CoordinatorFactory()
        return ApplicationCoordinator(instructor: instructor, router: router, coordinatorFactory: factory)
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        setupWindow(with: windowScene)
        applicationCoordinator?.start()
    }

    private func setupWindow(with windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = CoordinatorNavigationController()
    }
}
