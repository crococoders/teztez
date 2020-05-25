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
    private var isConverted: Bool = false

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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.dispatch(action: .didStopGame)
        store.dispatch(action: .didSendAnalytics)
    }

    @IBAction func primaryButtonDidTap(_ sender: PrimaryButton) {
        store.dispatch(action: isConverted ? .didReturnText : .didConvertText)
        animate()
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard let self = self, let state = state else { return }
            switch state {
            case let .initial(text, fontSize):
                self.updateTextView(with: text, fontSize: fontSize)
            case let .converted(text, fontSize):
                self.updateTextView(with: text, fontSize: fontSize)
                self.primaryButton.setTitle(R.string.blenderConvert.returnTitle(), for: .normal)
                self.primaryButton.isEnabled = true
                self.isConverted = true
            case let .returned(text, fontSize):
                self.updateTextView(with: text, fontSize: fontSize)
                self.primaryButton.setTitle(R.string.backwardsConvertText.convertTitle(), for: .normal)
                self.primaryButton.isEnabled = true
                self.isConverted = false
            case let .animating(text):
                self.primaryButton.isEnabled = false
                self.textView.text = text
            }
        }.store(in: &cancellables)
    }

    private func setupUI() {
        bottomView.applyGradient(colors: [UIColor.clear.cgColor, UIColor.systemGray.cgColor],
                                 direction: .topToBottom)
        textView.textContainerInset = Constants.edgeInsets
        navigationController?.navigationBar.barTintColor = .systemGray
        titleLabel.text = R.string.blenderConvert.mainTitle()
        primaryButton.setTitle(R.string.blenderConvert.convertTitle(), for: .normal)
    }

    private func updateTextView(with text: String, fontSize: CGFloat) {
        textView.text = text
        textView.font = R.font.sfProTextRegular(size: fontSize)
    }
    
    private func animate() {
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0.7
        }

        UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseOut, animations: {
            self.view.alpha = 1.0
        }, completion: nil)
    }

    override func customBackButtonDidTap() {
        onBackButtonDidTap?()
    }
}
