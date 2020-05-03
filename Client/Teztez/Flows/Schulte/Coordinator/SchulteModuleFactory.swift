//
//  SchulteModuleFactory.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol SchulteModuleFactory {
    func makeSchulteIntro() -> ActivitiesIntroPresentable
    func makeSchulteConfiguration() -> SchulteConfigurationPresentable
}

extension ModuleFactory: SchulteModuleFactory {
    func makeSchulteIntro() -> ActivitiesIntroPresentable {
        let viewModel = ActivitiesIntroViewModel(type: .schulte)
        let viewController = ActivitiesIntroViewController(viewModel: viewModel)
        return viewController
    }

    func makeSchulteConfiguration() -> SchulteConfigurationPresentable {
        let viewController = SchulteConfigurationViewController(store: SchulteConfigurationStore())
        return viewController
    }
}
