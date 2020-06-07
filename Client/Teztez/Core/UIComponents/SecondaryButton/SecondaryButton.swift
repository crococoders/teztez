//
//  SecondaryButton.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/2/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class SecondaryButton: UIButton {
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
        layer.cornerRadius = 10
        titleLabel?.font = .textSemibold17
        setTitleColor(.accentBlue, for: .normal)
    }
}
