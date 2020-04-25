//
//  CommonButton.swift
//  Teztez
//
//  Created by Adlet on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class CommonButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .mainBlue
        layer.cornerRadius = 10
        titleLabel?.font = .textSemibold17
        setTitleColor(.white, for: .normal)
    }
}
