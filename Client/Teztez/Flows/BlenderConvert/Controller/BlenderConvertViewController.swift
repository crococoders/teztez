//
//  BlenderConvertViewController.swift
//  Teztez
//
//  Created by Adlet on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol BlenderConvertPresentable: Presentable {
    var onBackButtonDidTap: Callback? { get set }
}

private enum Constants {
    static let edgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 140, right: 0)
}

final class BlenderConvertViewController: ViewController, BlenderConvertPresentable {
    var onBackButtonDidTap: Callback?

    private let store: BlenderConvertStore
    private var cancellables = Set<AnyCancellable>()
    private var isConverted: Bool?

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var primaryButton: PrimaryButton!
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var bottomView: UIView!

    init(store: BlenderConvertStore) {
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
                self.primaryButton.setTitle(R.string.blenderConvert.convertTitle(), for: .normal)
                self.isConverted = false
            case let .converted(text, fontSize):
                self.updateTextView(with: text, fontSize: fontSize)
                self.primaryButton.setTitle(R.string.blenderConvert.returnTitle(), for: .normal)
                self.isConverted = true
            }

        }.store(in: &cancellables)
    }

    private func setupUI() {
        bottomView.applyGradient(colors: [UIColor.systemGray.withAlphaComponent(0.8).cgColor,
                                          UIColor.systemGray.cgColor],
                                 direction: .topToBottom)
        setupLocalization()
        setupNavigationBar()
        setupTextView()
    }

    private func setupLocalization() {
        titleLabel.text = R.string.blenderConvert.mainTitle()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemGray
    }

    private func setupTextView() {
        textView.textContainerInset = Constants.edgeInsets
    }

    private func updateTextView(with text: String, fontSize: CGFloat) {
        textView.text = text
        textView.font = R.font.sfProTextRegular(size: fontSize)
    }

    override func customBackButtonDidTap() {
        onBackButtonDidTap?()
    }
}
