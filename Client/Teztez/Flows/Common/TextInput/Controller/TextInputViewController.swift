//
//  TextInputViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 27/04/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol TextInputPresentable: Presentable {
    var onDoneButtonDidTap: ((_ text: String) -> Void)? { get set }
    var onCancelButtonDidTap: Callback? { get set }
}

private enum Constants {
    static let edgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 40)
    static let animationDuration = 0.2
}

final class TextInputViewController: ViewController, TextInputPresentable {
    var onDoneButtonDidTap: ((_ text: String) -> Void)?
    var onCancelButtonDidTap: Callback?

    private let store: TextInputStore
    private let textViewDelegate: TextInputTextViewDelegate
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private var textView: UITextView!
    @IBOutlet private var resetButton: UIButton!

    init(store: TextInputStore) {
        self.store = store
        textViewDelegate = TextInputTextViewDelegate(store: self.store)
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    @IBAction private func resetButtonDidTap() {
        textView.text = ""
        store.dispatch(action: .didResetText)
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .textSet(text):
                self.textView.text = text
                self.setResetButtonVisibility(true)
                self.setDoneButtonAvailability(true)
            case .reset:
                self.setResetButtonVisibility(false)
                self.setDoneButtonAvailability(false)
            case .textChanging:
                self.setResetButtonVisibility(true)
                self.setDoneButtonAvailability(true)
            case let .warned(viewModel):
                self.showActionSheet(with: viewModel)
            }
        }.store(in: &cancellables)
    }

    private func setupUI() {
        setupTextView()
        setupResetButton()
    }

    private func setupTextView() {
        textView.textContainerInset = Constants.edgeInsets
        textView.becomeFirstResponder()
        textView.delegate = textViewDelegate
    }

    private func setupResetButton() {
        resetButton.imageView?.contentMode = .scaleAspectFill
        resetButton.contentHorizontalAlignment = .fill
        resetButton.contentVerticalAlignment = .fill
    }

    private func setupNavigationBar() {
        title = R.string.textInput.navigationTitle()
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: .systemGray3)
        navigationController?.navigationBar.tintColor = .accentBlue
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.textInput.cancel(),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancelButtonDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.textInput.done(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(doneButtonDidTap))
        setDoneButtonAvailability(false)
    }

    private func setResetButtonVisibility(_ isVisible: Bool) {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.resetButton.alpha = isVisible ? 1.0 : 0.0
        }
        resetButton.isEnabled = isVisible
    }

    private func showActionSheet(with warningViewModel: ActionSheetViewModel) {
        showActionSheet(with: warningViewModel) { [weak self] in
            self?.onCancelButtonDidTap?()
        }
    }

    private func setDoneButtonAvailability(_ isAvailable: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = isAvailable
        navigationItem.rightBarButtonItem?.tintColor = isAvailable ? .accentBlue : .systemGray3
    }

    @objc
    private func doneButtonDidTap() {
        guard
            let text = textView.text,
            !text.isEmpty else { return }
        onDoneButtonDidTap?(text)
    }

    @objc
    private func cancelButtonDidTap() {
        guard !textView.text.isEmpty else {
            onCancelButtonDidTap?()
            return
        }
        store.dispatch(action: .didTapCancelButton)
    }
}
