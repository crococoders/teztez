//
//  UITextField+Indent.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UITextField {
    func addLeftIndent(width: CGFloat) {
        leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: 0)))
        leftViewMode = .always
    }

    func addRightIndent(width: CGFloat) {
        rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: 0)))
        rightViewMode = .always
    }
}
