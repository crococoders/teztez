//
//  StatisticsLongCell.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/7/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Models
import UIKit

final class StatisticsLongCell: UICollectionViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var valueLabel: UILabel!

    func configure(with viewModel: StatisticsLongViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        valueLabel.text = viewModel.value
        valueLabel.textColor = viewModel.valueColor
    }
}
