//
//  ActivitySwitchView.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol ActivitySwitchViewDelegate: class {
    func activitySwitchView(_ activitySwitchView: ActivitySwitchView, didChangeSwitchValue switchView: UISwitch)
}

final class ActivitySwitchView: UIView, NibOwnerLoadable {
    weak var delegate: ActivitySwitchViewDelegate?

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var switchView: UISwitch!
    @IBOutlet private var switchTitleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }

    @IBAction private func switchViewValueDidChange(_ sender: UISwitch) {
        delegate?.activitySwitchView(self, didChangeSwitchValue: sender)
    }

    func configure(with viewModel: ActivitySwitchViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        switchTitleLabel.text = viewModel.switchTitle
    }
}
