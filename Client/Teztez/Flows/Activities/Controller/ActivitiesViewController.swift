//
//  ActivitiesViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Combine
import UIKit

protocol ActivitiesPresentable: Presentable {
    var onItemDidSelect: ((_ itemType: ActivitiesItemType) -> Void)? { get set }
}

final class ActivitiesViewController: UIViewController, ActivitiesPresentable {
    var onItemDidSelect: ((_ itemType: ActivitiesItemType) -> Void)?

    private let store: ActivitiesStore
    private let collectionViewDelegate: ActivitiesCollectionViewDelegate
    private let collectionViewDataSource: ActivitiesCollectionViewDataSource
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet var collectionView: UICollectionView!

    init(store: ActivitiesStore) {
        self.store = store
        collectionViewDataSource = ActivitiesCollectionViewDataSource()
        collectionViewDelegate = ActivitiesCollectionViewDelegate(store: store)

        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
        store.dispatch(action: .didLoadView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .inital(items):
                self.collectionViewDataSource.items = items
                self.collectionViewDelegate.items = items
                self.collectionView.reloadData()
            case let .itemSelected(itemType):
                self.navigateToNextPage(with: itemType)
            }

        }.store(in: &cancellables)
    }

    private func setupNavigationBar() {
        title = R.string.activities.navigationTitle()
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupUI() {
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        collectionView.register(cellClass: ActivitiesCell.self)
    }

    private func navigateToNextPage(with type: ActivitiesItemType) {
        let viewController: UIViewController
        switch type {
        case .coach:
            let store = PersonalCoachStore()
            viewController = PersonalCoachViewController(store: store)
        default:
            let viewModel = ActivitiesIntroViewModel(type: type)
            viewController = ActivitiesIntroViewController(viewModel: viewModel)
        }

        let navigationController = CoordinatorNavigationController(rootViewController: viewController)
        navigationController.hero.isEnabled = true
        navigationController.hero.modalAnimationType = .selectBy(presenting: .pageIn(direction: .left),
                                                                 dismissing: .pageOut(direction: .right))
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}
