//
//  FontSizeChangeViewController.swift
//  Teztez
//
//  Created by Adlet on 4/28/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Combine
import UIKit

protocol FontSizeChangePresentable: Presentable {
    var onFontSizeDidSelect: ((_ fontSize: CGFloat) -> Void)? { get set }
    var onCancelButtonDidTap: Callback? { get set }
}

final class FontSizeChangeViewController: UIViewController, FontSizeChangePresentable {
    var onFontSizeDidSelect: ((CGFloat) -> Void)?
    var onCancelButtonDidTap: Callback?

    private var store: FontSizeChangeStore
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private var sliderView: SliderView!
    @IBOutlet private var titleLabel: UILabel!

    init(store: FontSizeChangeStore) {
        self.store = store
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupObservers()
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .initial(value):
                self.sliderView.configure(with: value)
                self.titleLabel.font = R.font.sfProTextRegular(size: CGFloat(value))
            case let .changingFontSize(fontSize):
                print(self.titleLabel.font.pointSize)
                self.titleLabel.animate(font: R.font.sfProTextRegular(size: fontSize)!, duration: 0.1)
                print(self.titleLabel.font.pointSize)
            case let .changeFontSizeFinished(fontSize):
                self.onFontSizeDidSelect?(fontSize)
            case .cancelled:
                self.onCancelButtonDidTap?()
            }
        }.store(in: &cancellables)
    }

    private func setup() {
        store.dispatch(action: .didLoadView)
        sliderView.delegate = self
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        title = R.string.fontSizeChange.navigationTitle()
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: .systemGray3)
        navigationController?.navigationBar.tintColor = .accentBlue
        navigationController?.navigationBar.barTintColor = .systemGray

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.fontSizeChange.cancel(),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancelButtonDidPress))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.fontSizeChange.done(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(doneButtonDidPress))
    }

    @objc
    private func doneButtonDidPress() {
        store.dispatch(action: .didTapDoneButton)
    }

    @objc
    private func cancelButtonDidPress() {
        store.dispatch(action: .didTapCancelButton)
    }
}

extension FontSizeChangeViewController: SliderViewDelegate {
    func sliderView(_ sliderView: UISlider, didChangeFontSize fontSize: CGFloat) {
        store.dispatch(action: .didChangeFontSize(value: fontSize))
    }
}
