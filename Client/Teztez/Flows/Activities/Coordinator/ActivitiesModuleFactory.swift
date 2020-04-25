//
//  ActivitiesModuleFactory.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol ActivitiesModuleFactory {
    func makeActivities() -> ActivitiesPresentable
}

extension ModuleFactory: ActivitiesModuleFactory {
    func makeActivities() -> ActivitiesPresentable {
        let store = ActivitiesStore()
        let viewController = ActivitiesViewController(store: store)
        return viewController
    }
}
