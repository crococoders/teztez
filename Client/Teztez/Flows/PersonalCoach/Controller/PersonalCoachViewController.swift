//
//  PersonalCoachViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 01/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol PersonalCoachPresentable: Presentable {}

final class PersonalCoachViewController: ViewController, PersonalCoachPresentable {
    private let store: PersonalCoachStore
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private var stackView: UIStackView!

    init(store: PersonalCoachStore) {
        self.store = store
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupViews()
        setupNavigationBar()
    }

    private func setupObservers() {
        store.$state.sink { [weak self] _ in
            guard let self = self else { return }
        }.store(in: &cancellables)
    }

    private func setupViews() {
        stackView.removeAllArrangedSubviews()
        stackView.spacing = 32.0
        let headerView = ActivityHeaderView()
        headerView.configure(with: ActivityHeaderViewModel(title: "Backwards",
                                                           description: "Make  your configuration and check your reading speed",
                                                           iconViewModel: ActivitiesIconViewModel(type: .backward)))
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(ActivityTextInputView())
        stackView.addArrangedSubview(ActivityTextInputView())
    }

    private func setupNavigationBar() {
        navigationController?.view.backgroundColor = .systemGray
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.closeIcon(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeButtonDidTap))
    }

    @objc
    private func closeButtonDidTap() {}
}
