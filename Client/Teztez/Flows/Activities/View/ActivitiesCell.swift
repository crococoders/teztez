//
//  ActivitiesCell.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/24/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class ActivitiesCell: UICollectionViewCell {
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var iconImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var iconImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var stackViewBottomConstraint: NSLayoutConstraint!

    func configure(with viewModel: ActivitiesViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        iconImageView.image = viewModel.image

        iconImageViewWidthConstraint.constant = viewModel.iconSize.width
        iconImageViewHeightConstraint.constant = viewModel.iconSize.height
        stackViewBottomConstraint.constant = viewModel.stackViewBottomConstraint

        applyGradient(colors: viewModel.colors)

        guard viewModel.isDescriptionHidden else { return }
        descriptionLabel.isHidden = true
        titleLabel.font = UIFont.textSemibold17
        titleLabel.textColor = .accentBlue
    }
}
