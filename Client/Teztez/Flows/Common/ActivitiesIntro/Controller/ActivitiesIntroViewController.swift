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
        let viewController: UIViewController
        switch viewModel.type {
        case .blender:
            viewController = BlenderConfigurationViewController(store: BlenderConfigurationStore())
        case .backwards:
            viewController = BackwardsConfigurationViewController(store: BackwardsConfigurationStore())
        default:
            viewController = BlenderConfigurationViewController(store: BlenderConfigurationStore())
        }

        viewController.hero.isEnabled = true
        navigationController?.hero.isEnabled = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.hero.navigationAnimationType = .fade
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension ActivitiesIntroViewController {
    func setupUI() {
        nextButton.setTitle(R.string.activitiesIntro.nextButtonTitle(), for: .normal)
        activityTitle.text = viewModel.title
        activityIconView.configure(with: viewModel.iconViewModel)
        nextButton.heroModifiers = [.fade]
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
        navigationController?.dismiss(animated: true)
    }

    func configureNavigationBar() {
        navigationController?.view.backgroundColor = .systemGray
        navigationController?.navigationBar.barTintColor = .systemGray
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.closeIcon(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeButtonDidTap))
    }
}
