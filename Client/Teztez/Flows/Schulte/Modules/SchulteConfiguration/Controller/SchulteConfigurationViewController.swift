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
    var onContinueButtonDidTap: Callback? { get set }

    func enablePauseMode()
}

final class SchulteConfigurationViewController: ViewController, SchulteConfigurationPresentable {
    var onCloseButtonDidTap: Callback?
    var onNextButtonDidTap: ((_ configuration: SchulteConfiguration) -> Void)?
    var onContinueButtonDidTap: Callback?

    private let store: SchulteConfigurationStore
    private var cancellables = Set<AnyCancellable>()
    private var configuration: SchulteConfiguration?

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

    @IBAction func startButtonDidTap(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            store.dispatch(action: .didTapStartButton)
        case 1:
            guard let configuration = configuration else { return }
            naviagateToTraining(configuration: configuration)
        default:
            break
        }
    }

    @IBAction func restartButtonDidTap(_ sender: UIButton) {
        store.dispatch(action: .didTapStartButton)
    }

    func enablePauseMode() {
        restartButton.isHidden = false
        startButton.setTitle(R.string.schulteConfiguration.continue(), for: .normal)
        startButton.tag = 1
        startButton.layoutIfNeeded()
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .initial(blocks):
                self.setupViews(from: blocks)
            case let .configured(configuration):
                self.naviagateToTraining(configuration: configuration)
            }
        }.store(in: &cancellables)
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = nil
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
        navigationController?.dismiss(animated: true)
    }

    private func naviagateToTraining(configuration: SchulteConfiguration) {
        let store = SchulteTrainingStore(configuration: configuration)
        let viewController = SchulteTrainingViewController(store: store)
        viewController.onBackButtonDidTap = { [weak self] configuration in
            guard let self = self else { return }
            self.enablePauseMode()
            self.configuration = configuration
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SchulteConfigurationViewController: ActivitySwitchViewDelegate {
    func activitySwitchView(_ activitySwitchView: ActivitySwitchView, didChangeSwitchValue switchView: UISwitch) {
        store.dispatch(action: .didChangeSwitchValue(value: switchView.isOn))
    }
}
