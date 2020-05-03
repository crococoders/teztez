//
//  BackwardsConfigurationViewController.swift
//  Teztez
//
//  Created by Adlet on 5/2/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Combine
import UIKit

protocol BackwardsConfigurationPresentable: Presentable {
    var onCloseButtonDidTap: Callback? { get set }
    var onTextInputDidTap: Callback? { get set }
    var onFontSizeChangeDidTap: Callback? { get set }
    var onStartButtonDidTap: ((_ configuration: BackwardsConfiguration) -> Void)? { get set }
    var onContinueButtonDidTap: Callback? { get set }

    func setUserText(_ text: String)
    func setUserFontSize(_ fontSize: CGFloat)
    func setupBackwardsPause()
}

private enum Constants {
    static let spacing: CGFloat = 32.0
}

final class BackwardsConfigurationViewController: ViewController, BackwardsConfigurationPresentable {
    var onCloseButtonDidTap: Callback?
    var onTextInputDidTap: Callback?
    var onFontSizeChangeDidTap: Callback?
    var onStartButtonDidTap: ((BackwardsConfiguration) -> Void)?
    var onContinueButtonDidTap: Callback?

    private let store: BackwardsConfigurationStore
    private var cancellables = Set<AnyCancellable>()

    private lazy var headerView = ActivityHeaderView()
    private lazy var inputTextView = ActivityTextInputView()
    private lazy var selectFontSizeView = ActivityTextInputView()

    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var startButton: PrimaryButton!
    @IBOutlet private var restartButton: SecondaryButton!

    init(store: BackwardsConfigurationStore) {
        self.store = store
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
            onContinueButtonDidTap?()
        default:
            break
        }
    }

    @IBAction func restartButtonDidTap(_ sender: SecondaryButton) {
        store.dispatch(action: .didStartDidTap)
    }

    func setUserText(_ text: String) {
        store.dispatch(action: .didSetUserText(text: text))
    }

    func setUserFontSize(_ fontSize: CGFloat) {
        store.dispatch(action: .didSelectFontSize(fontSize: fontSize))
    }

    func setupBackwardsPause() {
        startButton.setTitle(R.string.backwardsConvertText.continueTitle(), for: .normal)
        startButton.tag = 1
        restartButton.isHidden = false
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard let self = self, let state = state else { return }
            switch state {
            case let .initial(blocks):
                self.setupViews(from: blocks)
            case let .updated(block: block):
                self.updateBlock(block)
            case let .configured(configuration: configuration):
                self.onStartButtonDidTap?(configuration)
            }
        }.store(in: &cancellables)
    }

    private func setupUI() {
        stackView.spacing = Constants.spacing
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.closeIcon(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeButtonDidTap))
    }

    @objc
    private func closeButtonDidTap() {
        onCloseButtonDidTap?()
    }

    private func setupViews(from blocks: [BackwardsBlockType]) {
        stackView.removeAllArrangedSubviews()
        blocks.forEach { blockType in
            switch blockType {
            case let .header(viewModel):
                headerView.configure(with: viewModel)
                stackView.addArrangedSubview(headerView)
            case let .inputText(viewModel):
                inputTextView.delegate = self
                inputTextView.configure(with: viewModel)
                stackView.addArrangedSubview(inputTextView)
            case let .selectFont(viewModel):
                selectFontSizeView.delegate = self
                selectFontSizeView.configure(with: viewModel)
                stackView.addArrangedSubview(selectFontSizeView)
            }
        }
    }

    private func updateBlock(_ block: BackwardsBlockType) {
        switch block {
        case let .selectFont(viewModel):
            selectFontSizeView.configure(with: viewModel)
        case let .inputText(viewModel):
            inputTextView.configure(with: viewModel)
        default:
            break
        }
    }
}

extension BackwardsConfigurationViewController: ActivityTextInputViewDelegate {
    func activityTextInputView(_ activityTextInputView: ActivityTextInputView, didTapActionView actionView: UIView) {
        switch activityTextInputView {
        case inputTextView:
            onTextInputDidTap?()
        case selectFontSizeView:
            onFontSizeChangeDidTap?()
        default:
            break
        }
    }
}
