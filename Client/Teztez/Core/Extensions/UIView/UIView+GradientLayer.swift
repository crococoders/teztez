//
//  UIView+GradientLayer.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/25/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UIView {
    enum Direction {
        case topToBottom
        case bottomToTop
        case leftToRight
        case rightToLeft
    }

    func applyGradient(colors: [Any]?, locations: [NSNumber]? = [0.0, 1.0], direction: Direction = .leftToRight) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations

        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)

        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
