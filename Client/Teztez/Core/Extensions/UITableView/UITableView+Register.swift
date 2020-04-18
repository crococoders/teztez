//
//  UITableView+Cell.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UITableView {
    func register(cellClass: AnyClass) {
        let nib = UINib(nibName: "\(cellClass)", bundle: nil)
        register(nib, forCellReuseIdentifier: "\(cellClass)")
    }

    func register(aClass: AnyClass) {
        let nib = UINib(nibName: "\(aClass)", bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: "\(aClass)")
    }
}
