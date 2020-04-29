//
//  ActivityIconView.swift
//  Teztez
//
//  Created by Adlet on 4/25/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class ActivityIconView: UIView, NibOwnerLoadable {
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

    func configure(with viewModel: ActivitiesIntroViewModel) {
        imageView.image = viewModel.icon
        applyGradient(colors: viewModel.gradientColors)
    }
}
