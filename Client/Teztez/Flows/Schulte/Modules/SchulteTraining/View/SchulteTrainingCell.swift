//
//  SchulteTrainingCell.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class SchulteTrainingCell: UICollectionViewCell {
    @IBOutlet private var numberLabel: UILabel!

    func configure(with viewModel: SchulteTrainingViewModel) {
        numberLabel.text = viewModel.number
        setupViews(by: viewModel.state)
    }

    private func setupViews(by state: SchulteNumberState) {
        switch state {
        case .correct:
            contentView.applyGradient(colors: [UIColor.stGreenLight.cgColor, UIColor.systemGreen.cgColor])
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.contentView.layer.sublayers?.remove(at: 0)
            }
        case .incorrect:
            contentView.applyGradient(colors: [UIColor.stPinkLight.cgColor, UIColor.stPinkDark.cgColor])
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.contentView.layer.sublayers?.remove(at: 0)
            }
        case .none:
            guard contentView.layer.sublayers?.first is CAGradientLayer else { return }
            contentView.layer.sublayers?.remove(at: 0)
        }
    }
}
