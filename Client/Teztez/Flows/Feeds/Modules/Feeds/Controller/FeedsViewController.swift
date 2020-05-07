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
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private var collectionView: UICollectionView!
    init(store: FeedsStore) {
        self.store = store
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupNavigationBar()
    }

    private func setupObservers() {
        store.$state.sink { [weak self] _ in
            guard let self = self else { return }
        }.store(in: &cancellables)
    }

    private func setupNavigationBar() {
        navigationItem.title = "Hello!"
        navigationController?.navigationBar.barTintColor = .black
    }
}
