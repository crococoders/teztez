//
//  ActivitiesIntroBlockView.swift
//  Teztez
//
//  Created by Adlet on 4/25/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class ActivitiesIntroBlockView: UIView, NibLoadable {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    func configure(with viewModel: ActivitiesIntroBlockViewModel) {
        imageView.image = viewModel.icon
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
}
