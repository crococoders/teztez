//
//  BlockCell.swift
//  Teztez
//
//  Created by Adlet on 5/4/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class BlockCell: UICollectionViewCell {
    @IBOutlet private var blockView: UIView!

    override func prepareForReuse() {
        blockView.layer.sublayers?.remove(at: 0)
    }

    func configure(with viewModel: ColorMatchingTrainingViewModel) {
        blockView.applyGradient(colors: viewModel.gradientColors, direction: .leftToRight)
        setupViewBorder(by: viewModel.state)
    }

    private func setupViewBorder(by state: ColorMatchingTrainingState) {
        switch state {
        case .correct:
            layer.borderWidth = 3.0
            layer.borderColor = UIColor.white.cgColor
        case .none:
            layer.borderColor = UIColor.clear.cgColor
            layer.borderWidth = 0
        }
    }
}

final class ProgressView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyGradient(colors: [UIColor.stRedLight.cgColor,
                               UIColor.stGreenLight.cgColor])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyGradient(colors: [UIColor.stRedLight.cgColor,
                               UIColor.stGreenLight.cgColor])
    }
}
