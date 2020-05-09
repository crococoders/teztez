//
//  SettingsWebCell.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class SettingsWebCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupDisclosureIndicator(with: .systemGray5)
    }

    func configure(with viewModel: SettingsWebViewModel) {
        titleLabel.text = viewModel.title
    }
}
