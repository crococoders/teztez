//
//  CompositeAppDelegateConfigurator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

typealias SceneDelegateConfigurator = UIResponder & UIWindowSceneDelegate

final class CompositeSceneDelegateConfigurator: SceneDelegateConfigurator {
    private let configurators: [SceneDelegateConfigurator]

    init(configurators: [SceneDelegateConfigurator]) {
        self.configurators = configurators
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        configurators.forEach { _ = $0.scene?(scene, willConnectTo: session, options: connectionOptions) }
    }
}
