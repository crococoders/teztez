//
//  ActivitiesCollectionViewDataSource.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/25/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class ActivitiesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var items: [ActivitiesItemType] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ActivitiesCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: ActivitiesViewModel(type: items[indexPath.row]))
        return cell
    }
}
