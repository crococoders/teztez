//
//  ActivityPickerView.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class ActivitySelectValueView: UIView, NibOwnerLoadable {
    var pickerView = UIPickerView()

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var valueTextField: UITextField!

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
        valueTextField.text = viewModel.value
    }

    private func setup() {
        pickerView.backgroundColor = .systemGray
        valueTextField.inputView = pickerView
        valueTextField.addTarget(self, action: #selector(valueEditingDidBegin), for: .editingDidBegin)
        valueTextField.addTarget(self, action: #selector(valueEditingDidEnd), for: .editingDidEnd)
    }

    @objc
    private func valueEditingDidBegin() {
        valueTextField.textColor = .accentBlue
    }

    @objc
    private func valueEditingDidEnd() {
        valueTextField.textColor = .white
    }
}
