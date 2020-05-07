//
//  ColorMatchingCollectionViewDelegate.swift
//  Teztez
//
//  Created by Adlet on 5/4/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let minimumLineSpacing: CGFloat = 24
    static let minimumInteritemSpacing: CGFloat = 175
    static let width: CGFloat = 80
    static let height: CGFloat = 80
}

final class ColorMatchingCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    private let store: ColorMatchingTrainingStore

    init(store: ColorMatchingTrainingStore) {
        self.store = store
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.width, height: Constants.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumInteritemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        store.dispatch(action: .didTapBlockAt(index: indexPath.row))
    }
}
