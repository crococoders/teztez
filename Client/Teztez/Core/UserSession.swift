//
//  UserSession.swift
//  Teztez
//
//  Created by Adlet on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation
import Models

final class UserSession {
    static let shared = UserSession()

    var token: String? {
        KeychainStorage.token
    }

    var userId: String? {
        KeychainStorage.userID
    }

    var username: String? {
        KeychainStorage.username
    }

    var name: String? {
        KeychainStorage.name
    }

    var isExist: Bool {
        token != nil
    }

    private init() {}

    func saveToken(credentials: TokenResponse) {
        KeychainStorage.token = credentials.token
    }

    func start(credentials: UserResponse) {
        KeychainStorage.username = credentials.username
        KeychainStorage.name = credentials.name
        KeychainStorage.userID = credentials.id
    }

    func finish() {
        KeychainStorage.token = nil
    }
}

private extension KeychainStorage {
    @KeychainEnrty("token")
    static var token: String?

    @KeychainEnrty("userID")
    static var userID: String?

    @KeychainEnrty("username")
    static var username: String?

    @KeychainEnrty("name")
    static var name: String?
}
