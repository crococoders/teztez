//
//  UICollectionView.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/25/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as? T else {
            fatalError("register(cellClass:) has not been implemented")
        }
        return cell
    }
}
