//
//  UIAppDelegateConfigurator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let titleTextAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17, weight: .semibold),
                                                                     .foregroundColor: UIColor.white]
}

final class UIAppDelegateConfigurator: AppDelegateConfigurator {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBar()
        return true
    }

    private func setupNavigationBar() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = Constants.titleTextAttributes
        navigationBar.tintColor = .buttonGray
    }
}
