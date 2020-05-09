//
//  SettingsProfileViewModel.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct SettingsProfileViewModel {
    let name: String
    let username: String

    init(name: String, username: String) {
        self.name = name
        self.username = username.lowercased()
    }
}
