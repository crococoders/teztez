//
//  AuthStore.swift
//  Teztez
//
//  Created by Adlet on 08/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import UIKit

// TODO: - refactor
struct UserViewModel {
    let name: String
    let userName: String
    let password: String
    let confirmPassword: String
}

// swiftlint:disable all
final class AuthStore {
    enum Action {
        case didLoadView
        case didLogin(viewModel: UserViewModel)
    }

    enum State {
        case initial(image: UIImage, gradientColors: [CGColor])
        case registered
    }

    private let provider: AuthProvider
    private let userSession: UserSession

    @Published private(set) var state: State?

    init() {
        provider = AuthProvider()
        userSession = UserSession.shared
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            state = .initial(image: R.image.glassesIcon()!,
                             gradientColors: [UIColor.lightBlur.cgColor,
                                              UIColor.accentBlue.cgColor])
        case let .didLogin(viewModel):
            validate(viewModel: viewModel)
        }
    }

    private func validate(viewModel: UserViewModel) {
        guard
            !viewModel.userName.isEmpty,
            !viewModel.name.isEmpty,
            validatePasswords(password: viewModel.password, confirmPassword: viewModel.confirmPassword)
        else { return print("error") }
        registerUser(viewModel: viewModel)
    }

    private func validatePasswords(password: String, confirmPassword: String) -> Bool {
        if password == confirmPassword {
            return true
        } else {
            return false
        }
    }

    private func registerUser(viewModel: UserViewModel) {
        provider.register(viewModel: viewModel) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(user):
                self.userSession.start(credentials: user)
                self.loginUser(userName: viewModel.userName, password: viewModel.password)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func loginUser(userName: String, password: String) {
        provider.login(username: userName, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(token):
                self.userSession.saveToken(credentials: token)
                self.state = .registered
                print(token)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
