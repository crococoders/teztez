//
//  BlockCell.swift
//  Teztez
//
//  Created by Adlet on 5/4/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class BlockCell: UICollectionViewCell {
    @IBOutlet private var blockView: UIView!

    override func prepareForReuse() {
        blockView.layer.sublayers?.remove(at: 0)
    }

    func configure(with color: [CGColor]) {
        blockView.applyGradient(colors: color, direction: .leftToRight)
    }
}
