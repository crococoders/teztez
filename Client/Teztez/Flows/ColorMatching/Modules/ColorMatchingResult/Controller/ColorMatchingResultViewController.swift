//
//  ColorMatchingResultViewController.swift
//  Teztez
//
//  Created by Adlet on 06/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol ColorMatchingResultPresentable: Presentable {
    var onHomeButtonDidTap: Callback? { get set }
    var onRestartButtonDidTap: Callback? { get set }
}

final class ColorMatchingResultViewController: ViewController, ColorMatchingResultPresentable {
    var onHomeButtonDidTap: Callback?
    var onRestartButtonDidTap: Callback?

    private let store: ColorMatchingResultStore
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var homeButton: PrimaryButton!
    @IBOutlet var restartButton: SecondaryButton!

    init(store: ColorMatchingResultStore) {
        self.store = store
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
        store.dispatch(action: .didLoadView)
        restartButton.heroID = "button"
    }

    @IBAction func homeButtonDidTap(_ sender: PrimaryButton) {
        navigationController?.dismiss(animated: true)
    }

    @IBAction func restartButtonDidTap(_ sender: UIButton) {
        let store = ColorMatchingConfigurationStore()
        let viewController = ColorMatchingConfigurationViewController(store: store)
        navigationController?.setViewControllers([viewController], animated: true)
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .initial(scoreResult):
                self.resultLabel.text = R.string.colorMatchingResult.resultMessage() + scoreResult
                self.resultLabel.heroModifiers = [.fade, .scale(0.5)]
                self.messageLabel.heroModifiers = [.fade, .scale(0.5)]
                self.homeButton.heroModifiers = [.fade]
                self.restartButton.heroModifiers = [.fade]
            }
        }.store(in: &cancellables)
    }

    private func setupUI() {
        setupNavigationBar()
        setupLocalization()
    }

    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
    }

    private func setupLocalization() {
        homeButton.setTitle(R.string.colorMatchingResult.home(), for: .normal)
        restartButton.setTitle(R.string.colorMatchingResult.restart(), for: .normal)
        messageLabel.text = R.string.colorMatchingResult.goodJob()
    }
}
