//
//  StatisticsSmallCell.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/7/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class StatisticsSmallCell: UICollectionViewCell {
    @IBOutlet private var valueLabel: UILabel!
    @IBOutlet private var activityIconImageView: UIImageView!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!

    func configure(with viewModel: StatisticsSmallViewModel) {
        valueLabel.text = viewModel.value
        valueLabel.textColor = viewModel.valueColor
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        activityIconImageView.image = viewModel.icon
    }
}
