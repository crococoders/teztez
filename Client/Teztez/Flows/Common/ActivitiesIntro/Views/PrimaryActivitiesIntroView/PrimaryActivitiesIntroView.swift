//
//  PrimaryActivitiesIntroView.swift
//  Teztez
//
//  Created by Adlet on 4/25/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class PrimaryActivitiesIntroView: UIView, NibLoadable {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    func configure(with data: ActivitiesIntroViewModel, isUsageView: Bool) {
        guard isUsageView else {
            imageView.image = data.activityInfoImage
            titleLabel.text = data.activityInfoTitle
            descriptionLabel.text = data.activityInfoDescription

            return
        }

        imageView.image = data.activityUsageImage
        titleLabel.text = data.activityUsageTitle
        descriptionLabel.text = data.activityUsageDescription
    }
}
