//
//  NavigationBarSceneDelegateConfigurator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/20/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let titleTextAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.textSemibold17,
                                                                     .foregroundColor: UIColor.white]
    static let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.displayBold34,
                                                                          .foregroundColor: UIColor.white]
}

class NavigationBarSceneDelegateConfigurator: SceneDelegateConfigurator {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = Constants.titleTextAttributes
        navigationBar.largeTitleTextAttributes = Constants.largeTitleTextAttributes
        navigationBar.tintColor = .buttonGray
        navigationBar.barStyle = .default
    }
}
