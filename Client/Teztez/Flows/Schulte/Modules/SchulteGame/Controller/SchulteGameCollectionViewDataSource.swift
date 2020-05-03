//
//  SchulteGameCollectionViewDataSource.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class SchulteGameCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var numbers: [Int] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numbers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SchulteGameCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: SchulteGameViewModel(number: "\(numbers[indexPath.row])"))
        return cell
    }
}
