//
//  BlockCell.swift
//  Teztez
//
//  Created by Adlet on 5/4/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let animationDuration = 0.2
    static let customTransform = CGAffineTransform(scaleX: 0.95, y: 0.95)
}

class BlockCell: UICollectionViewCell {
    override var isHighlighted: Bool {
        didSet {
            animateScale()
        }
    }

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

    private func animateScale() {
        if isHighlighted {
            UIView.animate(withDuration: Constants.animationDuration) {
                self.transform = Constants.customTransform
            }
        } else {
            UIView.animate(withDuration: Constants.animationDuration) {
                self.transform = .identity
            }
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
