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

    @IBOutlet private var activityIconContainerView: ActivityIconContainerView!
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

    @IBAction func onCloseDidTap(_ sender: UIBarButtonItem) {
        onCloseButtonDidTap?()
    }
}

private extension ActivitiesIntroViewController {
    func setupUI() {
        nextButton.setTitle(R.string.activitiesIntro.nextButtonTitle(), for: .normal)
        activityTitle.text = viewModel.activityTitle
        activityIconContainerView.configure(with: viewModel)
        setupContainerView()
    }

    func setupContainerView() {
        let views: [PrimaryActivitiesIntroView] = Array(count: 2, factory: .loadFromNib())
        containerView.addArrangedSubviews(views)

        for (index, view) in containerView.arrangedSubviews.enumerated() {
            let activityView = view as? PrimaryActivitiesIntroView
            switch index {
            case 0:
                activityView?.configure(with: viewModel, isUsageView: false)
            case 1:
                activityView?.configure(with: viewModel, isUsageView: true)
            default:
                break
            }
        }
    }
}
