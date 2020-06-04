//
//  UILabel+Animate.swift
//  Teztez
//
//  Created by Almas Zainoldin on 6/4/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UILabel {
    func animate(font: UIFont, duration: TimeInterval) {
        let labelScale = self.font.pointSize / font.pointSize
        self.font = font
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            self.transform = oldTransform
            self.layoutIfNeeded()
        }
    }
}
