//
//  AuthViewController.swift
//  Teztez
//
//  Created by Adlet on 08/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol AuthPresentable: Presentable {
    var onRegisterDidFinish: Callback? { get set }
}

final class AuthViewController: ViewController, AuthPresentable {
    var onRegisterDidFinish: Callback?

    private let store: AuthStore
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private var iconView: ActivityIconView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var passwordLabel: UILabel!
    @IBOutlet private var confirmPasswordLabel: UILabel!
    @IBOutlet private var usernameTextField: PrimaryTextField!
    @IBOutlet private var nameTextField: PrimaryTextField!
    @IBOutlet private var passwordTextField: PrimaryTextField!
    @IBOutlet private var confirmPasswordTextField: PrimaryTextField!
    @IBOutlet private var signUpButton: PrimaryButton!

    init(store: AuthStore) {
        self.store = store
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
        store.dispatch(action: .didLoadView)
    }

    @IBAction func signUpDidTap(_ sender: PrimaryButton) {
        guard
            let name = nameTextField.text,
            let username = usernameTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text else { return }

        let user = UserViewModel(name: name,
                                 userName: username,
                                 password: password,
                                 confirmPassword: confirmPassword)

        store.dispatch(action: .didLogin(viewModel: user))
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard let self = self, let state = state else { return }
            switch state {
            case let .initial(image, gradientColors):
                self.iconView.configureLoginIcon(with: image, and: gradientColors)
            case .registered:
                self.onRegisterDidFinish?()
            }
        }.store(in: &cancellables)
    }

    private func setupUI() {
        setupLocalization()
    }

    private func setupLocalization() {
        titleLabel.text = R.string.auth.title()
        subtitleLabel.text = R.string.auth.subtitle()
        nameLabel.text = R.string.auth.enterName()
        usernameLabel.text = R.string.auth.enterUsername()
        passwordLabel.text = R.string.auth.enterPassword()
        confirmPasswordLabel.text = R.string.auth.confirmPassword()
        signUpButton.setTitle(R.string.auth.signUpTitle(), for: .normal)
    }
}
