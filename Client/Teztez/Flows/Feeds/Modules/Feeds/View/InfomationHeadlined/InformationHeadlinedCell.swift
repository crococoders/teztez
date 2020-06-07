//
//  InformationHeadlinedCell.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Kingfisher
import UIKit

final class InformationHeadlinedCell: UICollectionViewCell {
    @IBOutlet private var weekDayLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var metaTitleLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var coverImageView: UIImageView!

    func configure(with viewModel: InformationHeadlinedViewModel) {
        weekDayLabel.text = viewModel.weekDay
        dateLabel.text = viewModel.date
        metaTitleLabel.text = viewModel.metaTitle
        titleLabel.text = viewModel.title
        coverImageView.kf.setImage(with: URL(string: viewModel.imageURL))
//        gradientView.layer.sublayers?.remove(at: 0)
//        gradientView.applyGradient(colors: [UIColor.black.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor],
//                                   locations: [0.0, 0.8],
//                                   direction: .topToBottom)
        titleLabel.heroID = viewModel.title
        metaTitleLabel.heroID = viewModel.metaTitle
        coverImageView.heroID = viewModel.imageURL
    }
}
