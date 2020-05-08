//
//  InformationDetailedCell.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class InformationDetailedCell: UICollectionViewCell {
    @IBOutlet private var weekDayLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var metaTitleLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var coverImageView: UIImageView!

    func configure(with viewModel: InformationDetailedViewModel) {
        weekDayLabel.text = viewModel.weekDay
        dateLabel.text = viewModel.date
        metaTitleLabel.text = viewModel.metaTitle
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        coverImageView.kf.setImage(with: URL(string: viewModel.imageURL))
    }
}
