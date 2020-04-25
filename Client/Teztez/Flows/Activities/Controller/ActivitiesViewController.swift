//
//  ActivitiesViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol ActivitiesPresentable: Presentable {
    var onItemDidSelect: ((_ indexPath: Int) -> Void)? { get set }
}

final class ActivitiesViewController: UIViewController, ActivitiesPresentable {
    var onItemDidSelect: ((Int) -> Void)?

    private let store: ActivitiesStore
    private let collectionViewDelegate: ActivitiesCollectionViewDelegate
    private let collectionViewDataSource: ActivitiesCollectionViewDataSource

    @IBOutlet var collectionView: UICollectionView!

    init(store: ActivitiesStore) {
        self.store = store
        collectionViewDataSource = ActivitiesCollectionViewDataSource()
        collectionViewDelegate = ActivitiesCollectionViewDelegate()

        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        store.dispatch(action: .didLoadView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        title = R.string.activities.navigationTitle()
        navigationController?.navigationBar.barTintColor = .black
    }

    private func setupUI() {
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        collectionView.register(cellClass: ActivitiesCell.self)
    }
}
