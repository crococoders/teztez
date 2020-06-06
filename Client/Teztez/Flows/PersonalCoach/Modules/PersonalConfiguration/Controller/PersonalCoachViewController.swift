//
//  PersonalCoachViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 01/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol PersonalCoachPresentable: Presentable {
    var onCloseButtonDidTap: Callback? { get set }
    var onTextInputDidTap: Callback? { get set }
    var onStartButtonDidTap: ((_ configuration: PersonalCoachConfiguration) -> Void)? { get set }
    var onContinueButtonDidTap: Callback? { get set }

    func setUserText(_ text: String)
    func enablePauseMode()
}

private enum Constants {
    static let spacing: CGFloat = 32.0
}

final class PersonalCoachViewController: ViewController, PersonalCoachPresentable {
    var onCloseButtonDidTap: Callback?
    var onTextInputDidTap: Callback?
    var onStartButtonDidTap: ((_ configuration: PersonalCoachConfiguration) -> Void)?
    var onContinueButtonDidTap: Callback?

    private let store: PersonalCoachStore
    private let pickerViewDelegate: PersonalCoachPickerViewDelegate
    private let pickerViewDataSource: PersonalCoachPickerViewDataSource
    private var cancellables = Set<AnyCancellable>()
    private var configuration: PersonalCoachConfiguration?

    private lazy var headerView = ActivityHeaderView()
    private lazy var inputTextView = ActivityTextInputView()
    private lazy var selectSpeedView = ActivitySelectValueView()

    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var startButton: PrimaryButton!
    @IBOutlet private var restartButton: SecondaryButton!

    init(store: PersonalCoachStore) {
        self.store = store
        pickerViewDelegate = PersonalCoachPickerViewDelegate(store: store)
        pickerViewDataSource = PersonalCoachPickerViewDataSource(store: store)
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
        startButton.heroID = "button"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
    }

    @IBAction func startButtonDidTap(_ sender: PrimaryButton) {
        switch sender.tag {
        case 0:
            store.dispatch(action: .didStartDidTap)
        case 1:
            navigateToTraining(with: configuration!)
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

    func enablePauseMode() {
        restartButton.isHidden = false
        startButton.setTitle("Continue", for: .normal)
        startButton.layoutSubviews()
        startButton.tag = 1
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .initial(blocks):
                self.setupViews(from: blocks)
            case let .updated(block):
                self.updateBlock(block)
            case let .configured(configuration):
                self.configuration = configuration
                self.navigateToTraining(with: configuration)
            }

        }.store(in: &cancellables)
    }

    private func setupUI() {
        stackView.spacing = Constants.spacing
        navigationItem.setLeftBarButton(nil, animated: false)
        setupLocalization()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.closeIcon(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeButtonDidTap))
    }

    private func setupLocalization() {
        startButton.setTitle(R.string.personalCoach.start(), for: .normal)
        restartButton.setTitle(R.string.personalCoach.restart(), for: .normal)
    }

    private func setupViews(from blocks: [PersonalCoachBlockType]) {
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
            case let .selectSpeed(viewModel):
                selectSpeedView.configure(with: viewModel)
                selectSpeedView.pickerView.delegate = pickerViewDelegate
                selectSpeedView.pickerView.dataSource = pickerViewDataSource
                stackView.addArrangedSubview(selectSpeedView)
            }
        }
    }

    private func updateBlock(_ block: PersonalCoachBlockType) {
        switch block {
        case let .selectSpeed(viewModel):
            selectSpeedView.configure(with: viewModel)
        case let .inputText(viewModel):
            inputTextView.configure(with: viewModel)
        default:
            break
        }
    }

    @objc
    private func closeButtonDidTap() {
        navigationController?.dismiss(animated: true)
    }

    private func navigateToTraining(with configuration: PersonalCoachConfiguration) {
        let store = PersonalCoachTrainingStore(configuration: configuration)
        let viewController = PersonalCoachTrainingViewController(store: store)
        viewController.onBackButtonDidTap = { [weak self, weak viewController] currentIndex in
            guard let self = self else { return }
            self.enablePauseMode()
            self.configuration?.startWordIndex = currentIndex
            viewController?.navigationController?.popViewController(animated: true)
        }
        viewController.hero.isEnabled = true
        navigationController?.hero.isEnabled = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.hero.navigationAnimationType = .fade

        navigationController?.pushViewController(viewController, animated: true)
    }

    private func navigateToTextInput() {
        let viewController = TextInputViewController(store: TextInputStore())
        let navController = CoordinatorNavigationController()
        viewController.onDoneButtonDidTap = { [weak self, weak viewController] text in
            viewController?.dismiss(animated: true)
            self?.setUserText(text)
        }
        viewController.onCancelButtonDidTap = { [weak viewController] in
            viewController?.dismiss(animated: true)
        }
        navController.setViewControllers([viewController], animated: true)
        navigationController?.present(navController, animated: true)
    }
}

extension PersonalCoachViewController: ActivityTextInputViewDelegate {
    func activityTextInputView(_ activityTextInputView: ActivityTextInputView, didTapActionView actionView: UIView) {
        navigateToTextInput()
    }
}
