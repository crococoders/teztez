//
//  FeedsStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 05/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

final class FeedsStore {
    enum Action {}
    enum State {}

    @Published private(set) var state: State?

    func dispatch(action: Action) {}
}
