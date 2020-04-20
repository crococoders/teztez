//
//  UITableViewCell+SelectedBackgroundView.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func setupSelectedBackgroundView(with color: UIColor) {
        selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = color
            return view
        }()
    }
}
