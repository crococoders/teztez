//
//  PrimaryTextField.swift
//  Teztez
//
//  Created by Adlet on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class PrimaryTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .systemGray2
        font = .textRegulard15
        textColor = .white
        textAlignment = .left
        layer.cornerRadius = 10
        layer.masksToBounds = true
        addLeftIndent(width: 16)
        addRightIndent(width: 16)
    }
}
