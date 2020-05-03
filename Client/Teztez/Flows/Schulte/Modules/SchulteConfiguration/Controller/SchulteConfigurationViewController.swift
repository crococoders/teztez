//
//  SchulteConfigurationViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol SchulteConfigurationPresentable: Presentable {
    var onCloseButtonDidTap: Callback? { get set }
    var onNextButtonDidTap: ((_ configuration: SchulteConfiguration) -> Void)? { get set }
}

final class SchulteConfigurationViewController: ViewController, SchulteConfigurationPresentable {
    var onCloseButtonDidTap: Callback?
    var onNextButtonDidTap: ((_ configuration: SchulteConfiguration) -> Void)?

    private let store: SchulteConfigurationStore
    private var cancellables = Set<AnyCancellable>()

    private lazy var headerView = ActivityHeaderView()
    private lazy var inverseView = ActivitySwitchView()

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var startButton: PrimaryButton!
    @IBOutlet var restartButton: SecondaryButton!

    init(store: SchulteConfigurationStore) {
        self.store = store
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupObservers()
        store.dispatch(action: .didLoadView)
    }

    @IBAction func startButtonDidTap(_ sender: UIButton) {}
    @IBAction func restartButtonDidTap(_ sender: UIButton) {}

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .initial(blocks):
                self.setupViews(from: blocks)
            }
        }.store(in: &cancellables)
    }

    private func setupNavigationBar() {
        navigationController?.view.backgroundColor = .systemGray
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.closeIcon(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeButtonDidTap))
    }

    private func setupViews(from blocks: [SchulteBlockType]) {
        stackView.removeAllArrangedSubviews()
        blocks.forEach { blockType in
            switch blockType {
            case let .header(viewModel):
                headerView.configure(with: viewModel)
                stackView.addArrangedSubview(headerView)
            case let .inverse(viewModel):
                inverseView.configure(with: viewModel)
                inverseView.delegate = self
                stackView.addArrangedSubview(inverseView)
            }
        }
    }

    @objc
    private func closeButtonDidTap() {
        onCloseButtonDidTap?()
    }
}

extension SchulteConfigurationViewController: ActivitySwitchViewDelegate {
    func activitySwitchView(_ activitySwitchView: ActivitySwitchView, didChangeSwitchValue: UISwitch) {}
}
