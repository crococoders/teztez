//
//  NibOwnerLoadable.swift
//  Teztez
//
//  Created by Adlet on 4/25/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol NibOwnerLoadable: class {
    static var nib: UINib { get }
}

extension NibOwnerLoadable {
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension NibOwnerLoadable where Self: UIView {
    func loadNibContent() {
        let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
        for case let view as UIView in type(of: self).nib.instantiate(withOwner: self, options: nil) {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            NSLayoutConstraint.activate(layoutAttributes.map {
                NSLayoutConstraint(item: view, attribute: $0, relatedBy: .equal, toItem: self, attribute: $0, multiplier: 1, constant: 0)
            })
        }
    }
}
