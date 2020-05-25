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
        store.dispatch(action: .didLoadView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.dispatch(action: .didStopGame)
        store.dispatch(action: .didSendAnalytics)
    }

    @IBAction func primaryButtonDidTap(_ sender: PrimaryButton) {
        guard let isConverted = isConverted else { return }
        isConverted ? store.dispatch(action: .didLoadView)
            : store.dispatch(action: .didConverText)
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
        bottomView.applyGradient(colors: [UIColor.clear.cgColor, UIColor.systemGray.cgColor],
                                 direction: .topToBottom)
        navigationController?.navigationBar.barTintColor = .systemGray
        textView.textContainerInset = Constants.edgeInsets
        titleLabel.text = R.string.backwardsConvertText.mainTitle()
        primaryButton.setTitle(R.string.backwardsConvertText.convertTitle(), for: .normal)
    }

    private func updateTextView(with text: String, fontSize: CGFloat) {
        textView.text = text
        textView.font = R.font.sfProTextRegular(size: fontSize)
    }

    override func customBackButtonDidTap() {
        onBackButtonDidTap?()
    }
}
