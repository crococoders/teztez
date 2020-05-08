//
//  FeedsViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 05/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol FeedsPresentable: Presentable {
    var onInformationSelected: ((_ details: InformationDetails) -> Void)? { get set }
}

final class FeedsViewController: ViewController, FeedsPresentable {
    var onInformationSelected: ((_ details: InformationDetails) -> Void)?

    private let store: FeedsStore
    private let collectionViewDataSource: FeedsCollectionViewDataSource
    private let collectionViewDelegate: FeedsCollectionViewDelegate
    private var cancellables = Set<AnyCancellable>()
    private let refreshControl = UIRefreshControl()

    @IBOutlet private var indicatorView: UIActivityIndicatorView!
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
            case let .infomrationSelected(details):
                self.onInformationSelected?(details)
            case .loading:
                self.indicatorView.startAnimating()
                self.indicatorView.isHidden = false
                self.collectionView.isHidden = true
            case .loaded:
                self.indicatorView.stopAnimating()
                self.collectionView.isHidden = false
            }
        }.store(in: &cancellables)
    }

    private func setupNavigationBar() {
        navigationItem.title = "Hello!"
        navigationController?.navigationBar.barTintColor = .black
    }

    private func setupUI() {
        indicatorView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDataSource
        refreshControl.addTarget(self, action: #selector(refreshDidPull), for: .valueChanged)
        refreshControl.tintColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl

        [StatisticsSmallCell.self,
         StatisticsLongCell.self,
         InformationHeadlinedCell.self,
         InformationDetailedCell.self].forEach { collectionView.register(cellClass: $0) }
    }

    @objc
    func refreshDidPull() {
        store.dispatch(action: .didForceRefresh)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}
