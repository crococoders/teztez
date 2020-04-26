//
//  ActivityIconContainerView.swift
//  Teztez
//
//  Created by Adlet on 4/25/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class ActivityIconContainerView: UIView, NibOwnerLoadable {
    @IBOutlet private var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        setup()
    }

    private func setup() {
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }

    func configure(with data: ActivitiesIntroViewModel) {
        imageView.image = data.activityImage
        applyGradient(colors: data.colors)
    }
}
