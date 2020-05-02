//
//  ActivityHeaderView.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let topConstraint: CGFloat = 16
    static let bottomConstraint: CGFloat = 0
}

final class ActivityHeaderView: UIView, NibOwnerLoadable {
    @IBOutlet private var iconView: ActivityIconView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var iconViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private var descriptionLabelBottomConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        setupUIAdaptation()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        setupUIAdaptation()
    }

    func configure(with viewModel: ActivityHeaderViewModel) {
        iconView.configure(with: viewModel.iconViewModel)
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }

    private func setupUIAdaptation() {
        guard Device.current.isSESecondGeneration else { return }
        iconViewTopConstraint.constant = Constants.topConstraint
        descriptionLabelBottomConstraint.constant = Constants.bottomConstraint
    }
}
