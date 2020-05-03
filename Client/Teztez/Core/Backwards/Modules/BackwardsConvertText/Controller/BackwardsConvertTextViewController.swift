//
//  BackwardsConvertTextViewController.swift
//  Teztez
//
//  Created by Adlet on 01/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol BackwardsConvertTextPresentable: Presentable {
    var onBackButtonDidTap: Callback? { get set }
}

private enum Constants {
    static let edgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 140, right: 0)
}

final class BackwardsConvertTextViewController: ViewController, BackwardsConvertTextPresentable {
    var onBackButtonDidTap: Callback?

    private let store: BackwardsConvertTextStore
    private var cancellables = Set<AnyCancellable>()
    private var isConverted: Bool?

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var primaryButton: PrimaryButton!
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var bottomView: UIView!

    init(store: BackwardsConvertTextStore) {
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
    }

    @IBAction func primaryButtonDidTap(_ sender: PrimaryButton) {
        switch isConverted {
        case .some(true):
            store.dispatch(action: .didLoadView)
        default:
            store.dispatch(action: .didConverText)
        }
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard let self = self, let state = state else { return }
            switch state {
            case let .initial(text, fontSize):
                self.updateTextView(with: text, fontSize: fontSize)
                self.primaryButton.setTitle(R.string.backwardsConvertText.convertTitle(), for: .normal)
                self.isConverted = false
            case let .converted(text, fontSize):
                self.updateTextView(with: text, fontSize: fontSize)
                self.primaryButton.setTitle(R.string.backwardsConvertText.returnTitle(), for: .normal)
                self.isConverted = true
            }

        }.store(in: &cancellables)
    }

    private func setupUI() {
        store.dispatch(action: .didLoadView)
        bottomView.applyGradient(colors: [UIColor.systemGray.withAlphaComponent(0.6).cgColor,
                                          UIColor.systemGray.cgColor],
                                 locations: [0, 1],
                                 direction: .topToBottom)
        setupNavigationBar()
        setupLocalization()
        setupTextView()
    }

    private func setupLocalization() {
        titleLabel.text = R.string.backwardsConvertText.mainTitle()
    }

    private func setupTextView() {
        textView.textContainerInset = Constants.edgeInsets
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemGray
    }

    private func updateTextView(with text: String, fontSize: CGFloat) {
        textView.text = text
        textView.font = R.font.sfProTextRegular(size: fontSize)
    }

    override func customBackButtonDidTap() {
        onBackButtonDidTap?()
    }
}
