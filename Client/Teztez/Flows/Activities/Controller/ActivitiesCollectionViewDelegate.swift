//
//  ActivitiesCollectionViewDelegate.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/25/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constant {
    static let collectionViewHeight: CGFloat = 115
    static let padding: CGFloat = 8
}

final class ActivitiesCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var collectionViewWidth = collectionView.frame.size.width

        switch indexPath.row {
        case 0:
            return CGSize(width: collectionViewWidth, height: Constant.collectionViewHeight)
        default:
            collectionViewWidth = collectionViewWidth - Constant.padding
            return CGSize(width: collectionViewWidth / 2, height: Constant.collectionViewHeight)
        }
    }
}
