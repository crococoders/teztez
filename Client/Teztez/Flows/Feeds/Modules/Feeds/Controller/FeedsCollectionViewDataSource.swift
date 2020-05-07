//
//  FeedsViewControllerDataSource.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class FeedsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var items: [FeedsItemType] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch items[indexPath.row] {
        case let .statisticsSmall(viewModel):
            let cell: StatisticsSmallCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: viewModel)
            return cell
        case let .statisticsLong(viewModel):
            let cell: StatisticsLongCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: viewModel)
            return cell
        case let .statisticsBig(viewModel):
            let cell: StatisticsSmallCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: viewModel)
            return cell
        case let .informationHeadlined(viewModel):
            let cell: InformationHeadlinedCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: viewModel)
            return cell
        }
    }
}
