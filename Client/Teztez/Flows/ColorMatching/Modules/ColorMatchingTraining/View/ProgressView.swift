//
//  ProgressView.swift
//  Teztez
//
//  Created by Adlet on 5/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyGradient(colors: [UIColor.stRedLight.cgColor,
                               UIColor.stGreenLight.cgColor])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyGradient(colors: [UIColor.stRedLight.cgColor,
                               UIColor.stGreenLight.cgColor])
    }
}
