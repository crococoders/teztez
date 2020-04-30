//
//  SceneConfiguratorFactory.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/20/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

enum SceneDelegateConfiguratorFactory {
    @discardableResult
    static func makeDefault() -> SceneDelegateConfigurator {
        return CompositeSceneDelegateConfigurator(configurators: [StartupSceneDelegateConfigurator(),
                                                                  NavigationBarSceneDelegateConfigurator(),
                                                                  ThirdPartiesSceneDelegateConfigurator()]
        )
    }
}
