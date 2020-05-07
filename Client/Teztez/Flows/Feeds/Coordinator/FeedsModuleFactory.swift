//
//  FeedsModuleFactory.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol FeedsModuleFactory {
    func makeFeeds() -> FeedsPresentable
}

extension ModuleFactory: FeedsModuleFactory {
    func makeFeeds() -> FeedsPresentable {
        let viewController = FeedsViewController(store: FeedsStore())
        return viewController
    }
}
