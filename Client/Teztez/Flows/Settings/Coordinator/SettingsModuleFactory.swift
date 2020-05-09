//
//  SettingsModuleFactory.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol SettingsModuleFactory {
    func makeSettings() -> SettingsPresentable
}

extension ModuleFactory: SettingsModuleFactory {
    func makeSettings() -> SettingsPresentable {
        let viewController = SettingsViewController(store: SettingsStore())
        return viewController
    }
}
