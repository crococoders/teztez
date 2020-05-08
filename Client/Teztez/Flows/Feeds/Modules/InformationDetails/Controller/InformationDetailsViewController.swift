//
//  InformationDetailsViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 08/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import Kingfisher
import UIKit

protocol InformationDetailsPresentable: Presentable {
    var onCloseButtonDidTap: Callback? { get set }
}

final class InformationDetailsViewController: ViewController, InformationDetailsPresentable {
    var onCloseButtonDidTap: Callback?

    private let store: InformationDetailsStore
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var metaTitleLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var gradientView: UIView!

    init(store: InformationDetailsStore) {
        self.store = store
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        gradientView.applyGradient(colors: [UIColor.black.withAlphaComponent(0.8).cgColor,
                                            UIColor.clear.cgColor],
                                   locations: [0.0, 0.8],
                                   direction: .topToBottom)
    }

    @IBAction func closeButtonDidTap() {
        onCloseButtonDidTap?()
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .initial(title, metaTitle, imageURL):
                self.titleLabel.text = title
                self.metaTitleLabel.text = metaTitle
                self.imageView.kf.setImage(with: imageURL)
            }
        }.store(in: &cancellables)
    }
}
