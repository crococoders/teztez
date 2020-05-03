//
//  ActivitySelectSizeView.swift
//  Teztez
//
//  Created by Adlet on 5/2/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol ActivitySelectSizeViewDelegate: class {
    func activitySelectSizeView(_ activitySelectSizeView: ActivitySelectSizeView, didTapActionView actionView: UIView)
}

class ActivitySelectSizeView: UIView, NibOwnerLoadable {
    weak var delegate: ActivitySelectSizeViewDelegate?

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var actionView: UIView!
    @IBOutlet var actionTitle: UILabel!

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

    func configure(with viewModel: ActivitySelectValueViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        actionTitle.text = viewModel.value
    }

    private func setup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionViewDidTap))
        actionView.addGestureRecognizer(tapGesture)
    }

    @objc
    private func actionViewDidTap() {
        delegate?.activitySelectSizeView(self, didTapActionView: actionView)
    }
}
