//
//  AppDelegateConfiguratorFactory.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

enum AppDelegateConfiguratorFactory {
    @discardableResult
    static func makeDefault() -> AppDelegateConfigurator {
        return CompositeAppDelegateConfigurator(configurators: [StartupAppDelegateConfigurator(),
                                                                ThirdPartiesAppDelegateConfigurator(),
                                                                UIAppDelegateConfigurator()])
    }
}
