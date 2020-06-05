//
//  BlenderConfigurationViewController.swift
//  Teztez
//
//  Created by Adlet on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol BlenderConfigurationPresentable: Presentable {
    var onCloseButtonDidTap: Callback? { get set }
    var onTextInputDidTap: Callback? { get set }
    var onFontSizeChangeDidTap: Callback? { get set }
    var onStartButtonDidTap: ((_ configuration: BlenderConfiguration) -> Void)? { get set }
    var onContinueButtonDidTap: Callback? { get set }

    func setUserText(_ text: String)
    func setUserFontSize(_ fontSize: CGFloat)
    func setupBlenderPause()
}

private enum Constants {
    static let spacing: CGFloat = 32.0
}

final class BlenderConfigurationViewController: ViewController, BlenderConfigurationPresentable {
    var onCloseButtonDidTap: Callback?
    var onTextInputDidTap: Callback?
    var onFontSizeChangeDidTap: Callback?
    var onStartButtonDidTap: ((BlenderConfiguration) -> Void)?
    var onContinueButtonDidTap: Callback?

    private let store: BlenderConfigurationStore
    private var cancellables = Set<AnyCancellable>()
    private var configuration: BlenderConfiguration?
    private var fontSize: CGFloat = 15

    private lazy var headerView = ActivityHeaderView()
    private lazy var inputTextView = ActivityTextInputView()
    private lazy var selectFontSizeView = ActivityTextInputView()

    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var startButton: PrimaryButton!
    @IBOutlet private var restartButton: SecondaryButton!

    init(store: BlenderConfigurationStore) {
        self.store = store
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        store.dispatch(action: .didLoadView)
        setupUI()
    }

    @IBAction func startButtonDidTap(_ sender: PrimaryButton) {
        switch sender.tag {
        case 0:
            store.dispatch(action: .didStartDidTap)
        case 1:
            guard let configuration = configuration else { return }
            navigateToBlenderConverter(configuration: configuration)
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

    func setupBlenderPause() {
        startButton.tag = 1
        restartButton.isHidden = false
        startButton.setTitle(R.string.backwardsConvertText.continueTitle(), for: .normal)
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
                self.configuration = configuration
                self.navigateToBlenderConverter(configuration: configuration)
            }
        }.store(in: &cancellables)
    }

    private func setupUI() {
        stackView.spacing = Constants.spacing
        startButton.heroID = "primaryButton"
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = nil
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.closeIcon(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeButtonDidTap))
    }

    @objc
    private func closeButtonDidTap() {
        navigationController?.dismiss(animated: true)
    }

    private func setupViews(from blocks: [BlenderBlockType]) {
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

    private func updateBlock(_ block: BlenderBlockType) {
        switch block {
        case let .selectFont(viewModel):
            selectFontSizeView.configure(with: viewModel)
        case let .inputText(viewModel):
            inputTextView.configure(with: viewModel)
        default:
            break
        }
    }

    private func navigateToTextInput() {
        let viewController = TextInputViewController(store: TextInputStore())
        viewController.onDoneButtonDidTap = { [weak self, weak viewController] text in
            viewController?.dismiss(animated: true)
            self?.setUserText(text)
        }
        viewController.onCancelButtonDidTap = { [weak viewController] in
            viewController?.dismiss(animated: true)
        }
        let navController = CoordinatorNavigationController(rootViewController: viewController)
        viewController.isModalInPresentation = true
        navigationController?.present(navController, animated: true)
    }

    private func navigateToTextSizeChange() {
        let store = FontSizeChangeStore(fontSize: fontSize)
        let viewController = FontSizeChangeViewController(store: store)
        viewController.onFontSizeDidSelect = { [weak self, weak viewController] fontSize in
            guard let self = self else { return }
            self.fontSize = fontSize
            self.setUserFontSize(fontSize)
            viewController?.dismiss(animated: true)
        }
        viewController.onCancelButtonDidTap = { [weak viewController] in
            viewController?.dismiss(animated: true)
        }
        let navController = CoordinatorNavigationController(rootViewController: viewController)
        viewController.isModalInPresentation = true
        navigationController?.present(navController, animated: true)
    }

    private func navigateToBlenderConverter(configuration: BlenderConfiguration) {
        let store = BlenderConvertStore(configuration: configuration)
        let viewController = BlenderConvertViewController(store: store)
        viewController.onBackButtonDidTap = { [weak self] in
            self?.setupBlenderPause()
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension BlenderConfigurationViewController: ActivityTextInputViewDelegate {
    func activityTextInputView(_ activityTextInputView: ActivityTextInputView, didTapActionView actionView: UIView) {
        switch activityTextInputView {
        case inputTextView:
            navigateToTextInput()
        case selectFontSizeView:
            navigateToTextSizeChange()
        default:
            break
        }
    }
}
