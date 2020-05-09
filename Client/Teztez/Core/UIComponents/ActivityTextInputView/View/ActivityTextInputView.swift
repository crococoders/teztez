//
//  ActivityTextInputView.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol ActivityTextInputViewDelegate: class {
    func activityTextInputView(_ activityTextInputView: ActivityTextInputView, didTapActionView actionView: UIView)
}

final class ActivityTextInputView: UIView, NibOwnerLoadable {
    weak var delegate: ActivityTextInputViewDelegate?

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var actionView: UIView!
    @IBOutlet private var actionTitleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

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

    func configure(with viewModel: ActivityTextInputViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        actionTitleLabel.text = viewModel.actionTitle
    }

    private func setup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionViewDidTap))
        actionView.addGestureRecognizer(tapGesture)
    }

    @objc
    private func actionViewDidTap() {
        delegate?.activityTextInputView(self, didTapActionView: actionView)
    }
}
