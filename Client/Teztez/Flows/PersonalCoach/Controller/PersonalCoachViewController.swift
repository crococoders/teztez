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
}

private enum Constants {
    static let spacing: CGFloat = 32.0
}

final class PersonalCoachViewController: ViewController, PersonalCoachPresentable {
    var onCloseButtonDidTap: Callback?
    var onTextInputDidTap: Callback?
    
    private let store: PersonalCoachStore
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private var stackView: UIStackView!

    init(store: PersonalCoachStore) {
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

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .initial(blocks):
                self.setupViews(from: blocks)
            }

        }.store(in: &cancellables)
    }

    private func setupUI() {
        stackView.spacing = Constants.spacing
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationController?.view.backgroundColor = .systemGray
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.closeIcon(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeButtonDidTap))
    }

    private func setupViews(from blocks: [PersonalCoachBlockType]) {
        stackView.removeAllArrangedSubviews()
        blocks.forEach { blockType in
            switch blockType {
            case let .header(viewModel):
                let headerView = ActivityHeaderView()
                headerView.configure(with: viewModel)
                stackView.addArrangedSubview(headerView)
            case let .inputText(viewModel):
                let inputTextView = ActivityTextInputView()
                inputTextView.delegate = self
                inputTextView.configure(with: viewModel)
                stackView.addArrangedSubview(inputTextView)
            }
        }
    }

    @objc
    private func closeButtonDidTap() {
        onCloseButtonDidTap?()
    }
}

extension PersonalCoachViewController: ActivityTextInputViewDelegate {
    func activityTextInputView(_ activityTextInputView: ActivityTextInputView, didTapActionView actionView: UIView) {
        onTextInputDidTap?()
    }
}
