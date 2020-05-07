//
//  ColorMatchingCollectionViewDataSource.swift
//  Teztez
//
//  Created by Adlet on 5/4/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let numberOfItemsInSection = 10
}

final class ColorMatchingCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var gradientColors: [[CGColor]] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.numberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BlockCell = collectionView.dequeueReusableCell(for: indexPath)
        let color = gradientColors[indexPath.row]
        cell.configure(with: color)
        return cell
    }
}
