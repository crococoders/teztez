//
//  KeychainStorage.swift
//  Teztez
//
//  Created by Adlet on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation
import KeychainAccess

@propertyWrapper
struct KeychainEnrty {
    var wrappedValue: String? {
        get {
            try? keychain.getString(key)
        }
        set {
            if let unwrappedValue = newValue {
                try? keychain.set(unwrappedValue, key: key)
            } else {
                try? keychain.remove(key)
            }
        }
    }

    private let key: String
    private let keychain: Keychain

    public init(_ key: String, keychain: Keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "")) {
        self.key = key
        self.keychain = keychain
    }
}

struct KeychainStorage {}
