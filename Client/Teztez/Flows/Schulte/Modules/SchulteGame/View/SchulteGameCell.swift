//
//  SchulteGameCell.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class SchulteGameCell: UICollectionViewCell {
    @IBOutlet private var numberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with viewModel: SchulteGameViewModel) {
        numberLabel.text = viewModel.number
    }
}
