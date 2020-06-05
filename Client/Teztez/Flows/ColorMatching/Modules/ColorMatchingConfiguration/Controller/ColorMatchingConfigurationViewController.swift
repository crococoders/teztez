//
//  ColorMatchingConfigurationViewController.swift
//  Teztez
//
//  Created by Adlet on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol ColorMatchingConfigurationPresentable: Presentable {
    var onCloseButtonDidTap: Callback? { get set }
    var onStartButtonDidTap: ((_ configuration: ColorMatchingConfiguration) -> Void)? { get set }
    var onContinueButtonDidTap: Callback? { get set }

    func enablePauseMode()
}

private enum Constants {
    static let spacing: CGFloat = 32.0
}

final class ColorMatchingConfigurationViewController: ViewController, ColorMatchingConfigurationPresentable {
    var onCloseButtonDidTap: Callback?
    var onStartButtonDidTap: ((ColorMatchingConfiguration) -> Void)?
    var onContinueButtonDidTap: Callback?

    private let store: ColorMatchingConfigurationStore
    private let pickerViewDelegate: ColorMatchingPickerViewDelegate
    private let pickerViewDataSource: ColorMatchingPickerViewDataSource
    private var cancellables = Set<AnyCancellable>()
    private var configuration: ColorMatchingConfiguration?

    private lazy var headerView = ActivityHeaderView()
    private lazy var selectDurationView = ActivitySelectValueView()

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var startButton: PrimaryButton!
    @IBOutlet var restartButton: SecondaryButton!

    init(store: ColorMatchingConfigurationStore) {
        self.store = store
        pickerViewDelegate = ColorMatchingPickerViewDelegate(store: store)
        pickerViewDataSource = ColorMatchingPickerViewDataSource(store: store)
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupUI()
        store.dispatch(action: .didLoadView)
    }

    @IBAction func startButtonDidTap(_ sender: PrimaryButton) {
        switch sender.tag {
        case 0:
            store.dispatch(action: .didStartDidTap)
        case 1:
            guard let configuration = configuration else { return }
            navigateToTraining(configuration: configuration)
        default:
            break
        }
    }

    @IBAction func restartButtonDidTap(_ sender: SecondaryButton) {
        store.dispatch(action: .didStartDidTap)
    }

    func enablePauseMode() {
        restartButton.isHidden = false
        startButton.setTitle(R.string.colorMatchingConfiguration.continue(), for: .normal)
        startButton.tag = 1
        startButton.layoutIfNeeded()
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard let self = self, let state = state else { return }
            switch state {
            case let .initial(blocks):
                self.setupViews(from: blocks)
            case let .updated(block):
                self.updateBlock(block)
            case let .configured(configuration):
                self.navigateToTraining(configuration: configuration)
            }

        }.store(in: &cancellables)
    }

    private func setupUI() {
        stackView.spacing = Constants.spacing
        setupNavigationBar()
        setupLocalization()
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = nil
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.closeIcon(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeButtonDidTap))
    }

    private func setupLocalization() {
        startButton.setTitle(R.string.colorMatchingConfiguration.start(), for: .normal)
        restartButton.setTitle(R.string.colorMatchingConfiguration.restart(), for: .normal)
    }

    private func setupViews(from blocks: [ColorMatchingBlockType]) {
        stackView.removeAllArrangedSubviews()
        blocks.forEach { blockType in
            switch blockType {
            case let .header(viewModel):
                headerView.configure(with: viewModel)
                stackView.addArrangedSubview(headerView)
            case let .selectDuration(viewModel):
                selectDurationView.configure(with: viewModel)
                selectDurationView.pickerView.delegate = pickerViewDelegate
                selectDurationView.pickerView.dataSource = pickerViewDataSource
                stackView.addArrangedSubview(selectDurationView)
            }
        }
    }

    private func updateBlock(_ block: ColorMatchingBlockType) {
        switch block {
        case let .selectDuration(viewModel):
            selectDurationView.configure(with: viewModel)
        default:
            break
        }
    }

    @objc
    private func closeButtonDidTap() {
        navigationController?.dismiss(animated: true)
    }

    private func navigateToTraining(configuration: ColorMatchingConfiguration) {
        let store = ColorMatchingTrainingStore(configuration: configuration)
        let viewController = ColorMatchingTrainingViewController(store: store)
        viewController.onBackButtonDidTap = { [weak self] configuration in
            guard let self = self else { return }
            self.enablePauseMode()
            self.configuration = configuration
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
