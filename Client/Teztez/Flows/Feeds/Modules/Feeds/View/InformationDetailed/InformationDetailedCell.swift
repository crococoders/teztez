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
    @IBOutlet public var metaTitleLabel: UILabel!
    @IBOutlet public var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet public var coverImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with viewModel: InformationDetailedViewModel) {
        weekDayLabel.text = viewModel.weekDay
        dateLabel.text = viewModel.date
        metaTitleLabel.text = viewModel.metaTitle
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        coverImageView.kf.setImage(with: URL(string: viewModel.imageURL))

        titleLabel.heroID = viewModel.title
        metaTitleLabel.heroID = viewModel.metaTitle
        coverImageView.heroID = viewModel.imageURL
    }
}
