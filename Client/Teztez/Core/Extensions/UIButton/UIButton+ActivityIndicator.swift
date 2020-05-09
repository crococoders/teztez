//
//  UIButton+ActivityIndicator.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

// swiftlint:disable all
private var originalButtonText: String?
private var activityIndicator: UIActivityIndicatorView!

extension UIButton {
    func showLoading() {
        originalButtonText = titleLabel?.text
        setTitle("", for: .normal)

        if activityIndicator == nil {
            activityIndicator = createActivityIndicator()
        }

        showSpinning()
    }

    func hideLoading() {
        setTitle(originalButtonText, for: .normal)
        isEnabled = true
        backgroundColor = .accentBlue
        activityIndicator.stopAnimating()
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.lightGray
        return activityIndicator
    }

    func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        isEnabled = false
        backgroundColor = UIColor.accentBlue.withAlphaComponent(0.5)
        addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }

    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraint(yCenterConstraint)
    }
}
