//
//  UICollectionView+Register.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/25/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register(cellClass: AnyClass) {
        let nib = UINib(nibName: "\(cellClass)", bundle: nil)
        register(nib, forCellWithReuseIdentifier: "\(cellClass)")
    }
}
