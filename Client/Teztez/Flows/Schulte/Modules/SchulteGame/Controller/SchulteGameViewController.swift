//
//  SchulteGameViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol SchulteGamePresentable: Presentable {}

final class SchulteGameViewController: ViewController, SchulteGamePresentable {
    private let store: SchulteGameStore
    private var collectionViewDataSource: SchulteGameCollectionViewDataSource
    private var collectionViewDelegate: SchulteGameCollectionViewDelegate
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var nextElementLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var messageLabel: UILabel!

    init(store: SchulteGameStore) {
        self.store = store
        collectionViewDataSource = SchulteGameCollectionViewDataSource()
        collectionViewDelegate = SchulteGameCollectionViewDelegate(store: store)
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupUI()
        store.dispatch(action: .didLoadView)
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .initial(numbers):
                self.collectionViewDataSource.numbers = numbers
                self.collectionViewDelegate.numbers = numbers
                self.collectionView.reloadData()
            case let .nextNumberUpdated(number):
                self.nextElementLabel.text = "Next \(number)"
            }
        }.store(in: &cancellables)
    }

    private func setupUI() {
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDataSource
        collectionView.register(cellClass: SchulteGameCell.self)
    }
}
