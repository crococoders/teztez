//
//  PrimaryButton.swift
//  Teztez
//
//  Created by Adlet on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class PrimaryButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .accentBlue80 : .accentBlue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .accentBlue
        layer.cornerRadius = 10
        titleLabel?.font = .textSemibold17
        setTitleColor(.white, for: .normal)
    }
}
