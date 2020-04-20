//
//  SceneDelegate.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/20/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let configurator = SceneDelegateConfiguratorFactory.makeDefault()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        configurator.scene?(scene, willConnectTo: session, options: connectionOptions)
    }
}
