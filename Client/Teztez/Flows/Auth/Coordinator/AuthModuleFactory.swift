//
//  AuthModuleFactory.swift
//  Teztez
//
//  Created by Adlet on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol AuthModuleFactory {
    func makeAuth() -> AuthPresentable
}

extension ModuleFactory: AuthModuleFactory {
    func makeAuth() -> AuthPresentable {
        let store = AuthStore()
        let viewController = AuthViewController(store: store)
        return viewController
    }
}
