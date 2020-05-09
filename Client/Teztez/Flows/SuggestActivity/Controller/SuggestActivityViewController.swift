//
//  SuggestActivityViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 05/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol SuggestActivityPresentable: Presentable {
    var onSendButtonDidTap: Callback? { get set }
    var onCancelButtonDidTap: Callback? { get set }
}

private enum Constants {
    static let edgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 40)
    static let animationDuration = 0.2
    static let placeholderAttributedString = NSAttributedString(string: R.string.suggestActivity.title(),
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
}

final class SuggestActivityViewController: ViewController, SuggestActivityPresentable {
    var onSendButtonDidTap: Callback?
    var onCancelButtonDidTap: Callback?

    private let store: SuggestActivityStore
    private let textViewDelegate: SuggestActivtityTextViewDelegate
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var feedBackTextView: UITextView!
    @IBOutlet private var resetButton: UIButton!

    init(store: SuggestActivityStore) {
        self.store = store
        textViewDelegate = SuggestActivtityTextViewDelegate(store: store)
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

    @IBAction func resetButtonDidTap(_ sender: UIButton) {
        feedBackTextView.text = ""
        store.dispatch(action: .didResetText)
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case .reset:
                self.setResetButtonVisibility(false)
                self.setDoneButtonAvailability(false)
            case .textChanging:
                self.setResetButtonVisibility(true)
                self.setDoneButtonAvailability(true)
            case .sended:
                self.onSendButtonDidTap?()
            }
        }.store(in: &cancellables)
    }

    private func setupUI() {
        setupTextField()
        setupTextView()
        setupResetButton()
    }

    private func setupTextField() {
        titleTextField.addLeftIndent(width: 16)
        titleTextField.addRightIndent(width: 16)
        titleTextField.attributedPlaceholder = Constants.placeholderAttributedString
    }

    private func setupTextView() {
        feedBackTextView.textContainerInset = Constants.edgeInsets
        feedBackTextView.becomeFirstResponder()
        feedBackTextView.delegate = textViewDelegate
    }

    private func setupResetButton() {
        resetButton.imageView?.contentMode = .scaleAspectFill
        resetButton.contentHorizontalAlignment = .fill
        resetButton.contentVerticalAlignment = .fill
    }

    private func setupNavigationBar() {
        title = R.string.suggestActivity.navigationTitle()
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: .systemGray3)
        navigationController?.navigationBar.tintColor = .accentBlue
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.suggestActivity.cancel(),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancelButtonDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.suggestActivity.send(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(sendButtonDidTap))
        setDoneButtonAvailability(false)
    }

    private func setResetButtonVisibility(_ isVisible: Bool) {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.resetButton.alpha = isVisible ? 1.0 : 0.0
        }
        resetButton.isEnabled = isVisible
    }

    private func setDoneButtonAvailability(_ isAvailable: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = isAvailable
        navigationItem.rightBarButtonItem?.tintColor = isAvailable ? .accentBlue : .systemGray3
    }

    @objc
    private func sendButtonDidTap() {
        guard
            let title = titleTextField.text,
            !title.isEmpty,
            let feedback = feedBackTextView.text,
            !feedback.isEmpty else { return }
        store.dispatch(action: .didSendFeedback(title: title, feedback: feedback))
    }

    @objc
    private func cancelButtonDidTap() {
        onCancelButtonDidTap?()
    }
}
