//
//  CompositeAppDelegateConfigurator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

typealias AppDelegateConfigurator = UIResponder & UIApplicationDelegate

final class CompositeAppDelegateConfigurator: AppDelegateConfigurator {
    private let configurators: [AppDelegateConfigurator]

    init(configurators: [AppDelegateConfigurator]) {
        self.configurators = configurators
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configurators.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }
}
