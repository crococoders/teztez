//
//  SuggestActivityModuleFactory.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol SuggestActivityModuleFactory {
    func makeSuggestActivity() -> SuggestActivityPresentable
}

extension ModuleFactory: SuggestActivityModuleFactory {
    func makeSuggestActivity() -> SuggestActivityPresentable {
        let viewController = SuggestActivityViewController(store: SuggestActivityStore())
        return viewController
    }
}
