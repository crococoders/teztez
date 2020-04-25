//
//  ActivitiesIntroViewController.swift
//  Teztez
//
//  Created by Adlet on 4/23/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol ActivitiesIntroPresentable: Presentable {
    var onNextDidTap: Callback? { get set }
}

final class ActivitiesIntroViewController: UIViewController, ActivitiesIntroPresentable {
    var onNextDidTap: Callback?

    private let store: ActivitiesIntroStore

    @IBOutlet private var titleImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var nextButton: CommonButton!

    @IBOutlet private var infoImageView: UIImageView!
    @IBOutlet private var infoTitleLabel: UILabel!
    @IBOutlet private var infoDescriptionLabel: UILabel!

    @IBOutlet private var usageImageView: UIImageView!
    @IBOutlet private var usageTitleLabel: UILabel!
    @IBOutlet private var usageDescriptionLabel: UILabel!

    init(store: ActivitiesIntroStore) {
        self.store = store
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        store.dispatch(action: .didLoadView)
    }

    @IBAction func nextButtonDidTap(_ sender: CommonButton) {
        onNextDidTap?()
    }

    @IBAction func onCloseDidTap(_ sender: UIButton) {}
}

private extension ActivitiesIntroViewController {
    func setupUI() {
        nextButton.setTitle(R.string.activitiesIntro.buttonNext(), for: .normal)
        setupObservers()
    }

    func setupObservers() {
        store.$state.observe(self) { vc, state in
            guard let state = state else { return }
            switch state {
            case let .update(activitiesIntro: data):
                vc.configure(with: data)
            }
        }
    }

    func configure(with data: ActivitiesIntro) {
        titleImageView.image = UIImage(named: data.image)
        titleLabel.text = data.title
        infoTitleLabel.text = data.infoTitle
        infoDescriptionLabel.text = data.infoDescr
        infoImageView.image = UIImage(named: data.infoImage)
        usageTitleLabel.text = data.usageTitle
        usageDescriptionLabel.text = data.usageDescr
        usageImageView.image = UIImage(named: data.usageImage)
    }
}
