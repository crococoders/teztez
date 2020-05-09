//
//  SettingsProfileCell.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Models
import UIKit

final class SettingsProfileCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var usernameLabel: UILabel!

    func configure(with viewModel: SettingsProfileViewModel) {
        nameLabel.text = viewModel.name
        usernameLabel.text = viewModel.username
    }
}
