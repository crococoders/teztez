//
//  FeedsViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 05/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol FeedsPresentable: Presentable {}

final class FeedsViewController: ViewController, FeedsPresentable {
    private let store: FeedsStore
    private let collectionViewDataSource: FeedsCollectionViewDataSource
    private let collectionViewDelegate: FeedsCollectionViewDelegate
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private var collectionView: UICollectionView!
    init(store: FeedsStore) {
        self.store = store
        collectionViewDataSource = FeedsCollectionViewDataSource()
        collectionViewDelegate = FeedsCollectionViewDelegate(store: store)
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()

        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.dispatch(action: .didLoadView)
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .initial(items):
                self.collectionViewDataSource.items = items
                self.collectionViewDelegate.items = items
                self.collectionView.reloadData()
            }
        }.store(in: &cancellables)
    }

    private func setupNavigationBar() {
        navigationItem.title = "Hello!"
        navigationController?.navigationBar.barTintColor = .black
    }

    private func setupUI() {
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDataSource
        [StatisticsSmallCell.self,
         StatisticsLongCell.self,
         InformationHeadlinedCell.self].forEach { collectionView.register(cellClass: $0) }
    }
}
