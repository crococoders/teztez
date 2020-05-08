//
//  FeedsCollectionViewDelegate.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constant {
    static let collectionViewHeight: CGFloat = 115
    static let padding: CGFloat = 12
}

final class FeedsCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    var items: [FeedsItemType] = []

    private let store: FeedsStore

    init(store: FeedsStore) {
        self.store = store
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var collectionViewWidth = collectionView.frame.size.width

        switch items[indexPath.row] {
        case .statisticsSmall:
            collectionViewWidth = collectionViewWidth - Constant.padding
            return CGSize(width: collectionViewWidth / 2, height: 105)
        case .statisticsLong:
            return CGSize(width: collectionViewWidth, height: 56)
        case .statisticsBig:
            return CGSize(width: collectionViewWidth, height: 101)
        case .informationHeadlined:
            return CGSize(width: collectionViewWidth, height: 442)
        case .informationDetailed:
            return CGSize(width: collectionViewWidth, height: 442)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        store.dispatch(action: .didSelectItem(itemType: items[indexPath.row]))
    }
}
