//
//  ActivitiesIntroViewController.swift
//  Teztez
//
//  Created by Adlet on 4/23/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol ActivitiesIntroPresentable: Presentable {
    var onNextButtonDidTap: Callback? { get set }
    var onCloseButtonDidTap: Callback? { get set }
}

final class ActivitiesIntroViewController: UIViewController, ActivitiesIntroPresentable {
    var onNextButtonDidTap: Callback?
    var onCloseButtonDidTap: Callback?

    private let viewModel: ActivitiesIntroViewModel

    @IBOutlet private var activityIconView: ActivityIconView!
    @IBOutlet private var activityTitle: UILabel!
    @IBOutlet private var nextButton: PrimaryButton!
    @IBOutlet private var containerView: UIStackView!

    init(viewModel: ActivitiesIntroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func nextButtonDidTap(_ sender: PrimaryButton) {
        onNextButtonDidTap?()
    }
}

private extension ActivitiesIntroViewController {
    func setupUI() {
        nextButton.setTitle(R.string.activitiesIntro.nextButtonTitle(), for: .normal)
        activityTitle.text = viewModel.title
        activityIconView.configure(with: viewModel)
        setupContainerView()
        configureNavigationBar()
    }

    func setupContainerView() {
        let views: [ActivitiesIntroBlockView] = Array(count: 2, factory: .loadFromNib())
        containerView.addArrangedSubviews(views)

        for (index, view) in containerView.arrangedSubviews.enumerated() {
            let activityView = view as? ActivitiesIntroBlockView
            activityView?.configure(with: viewModel.blocks[index])
        }
    }

    @objc
    func closeButtonDidTap() {
        onCloseButtonDidTap?()
    }

    func configureNavigationBar() {
        navigationController?.view.backgroundColor = .systemGray
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.closeIcon(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeButtonDidTap))
    }
}
