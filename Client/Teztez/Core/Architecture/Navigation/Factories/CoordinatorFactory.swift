//
//  CoordinatorFactory.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

public final class CoordinatorFactory {
    public func makeMainTabBarCoordinator(router: Router) -> Coordinator {
        let tabBarController = TabBarController()
        let coordinator = TabBarCoordinator(tabBarPresentable: tabBarController, router: router, coordinatorFactory: CoordinatorFactory())
        return coordinator
    }
}
