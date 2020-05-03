//
//  BlenderModuleFactory.swift
//  Teztez
//
//  Created by Adlet on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol BlenderModuleFactory {
    func makeBlenderActivityIntro() -> ActivitiesIntroPresentable
    func makeBlenderConfiguration() -> BlenderConfigurationPresentable
}

extension ModuleFactory: BlenderModuleFactory {
    func makeBlenderActivityIntro() -> ActivitiesIntroPresentable {
        let viewModel = ActivitiesIntroViewModel(type: .blender)
        let viewController = ActivitiesIntroViewController(viewModel: viewModel)
        return viewController
    }

    func makeBlenderConfiguration() -> BlenderConfigurationPresentable {
        let store = BlenderConfigurationStore()
        let viewController = BlenderConfigurationViewController(store: store)
        return viewController
    }
}
