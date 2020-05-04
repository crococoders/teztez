//
//  SchulteGameCollectionViewDataSource.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class SchulteGameCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var viewModels: [SchulteGameViewModel] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SchulteGameCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}
