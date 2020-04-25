//
//  ActivitiesCell.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/24/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let animationDuration = 0.2
    static let customTransform = CGAffineTransform(scaleX: 0.95, y: 0.95)
}

class ActivitiesCell: UICollectionViewCell {
    override var isHighlighted: Bool {
        didSet {
            animateScale()
        }
    }

    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var iconImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var iconImageViewWidthConstraint: NSLayoutConstraint!

    func configure(with viewModel: ActivitiesViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        iconImageView.image = viewModel.image
        applyGradient(colors: viewModel.colors)

        iconImageViewWidthConstraint.constant = viewModel.iconSize.width
        iconImageViewHeightConstraint.constant = viewModel.iconSize.height

        guard viewModel.isDescriptionHidden else { return }
        descriptionLabel.isHidden = true
        titleLabel.font = .textSemibold17
        titleLabel.textColor = .accentBlue
    }

    private func animateScale() {
        if isHighlighted {
            UIView.animate(withDuration: Constants.animationDuration) {
                self.transform = Constants.customTransform
            }
        } else {
            UIView.animate(withDuration: Constants.animationDuration) {
                self.transform = .identity
            }
        }
    }
}
