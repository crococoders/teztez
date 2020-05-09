//
//  SchulteTrainingCollectionViewDataSource.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class SchulteTrainingCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var viewModels: [SchulteTrainingViewModel] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SchulteTrainingCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}
