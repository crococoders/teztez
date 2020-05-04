//
//  SchulteTrainingViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol SchulteTrainingPresentable: Presentable {
    var onBackButtonDidTap: ((_ configuration: SchulteConfiguration) -> Void)? { get set }
    var onTrainingDidFinish: ((_ time: String) -> Void)? { get set }
}

final class SchulteTrainingViewController: ViewController, SchulteTrainingPresentable {
    var onBackButtonDidTap: ((_ configuration: SchulteConfiguration) -> Void)?
    var onTrainingDidFinish: ((_ time: String) -> Void)?

    private let store: SchulteTrainingStore
    private var collectionViewDataSource: SchulteTrainingCollectionViewDataSource
    private var collectionViewDelegate: SchulteTrainingCollectionViewDelegate
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var nextElementLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var messageLabel: UILabel!

    init(store: SchulteTrainingStore) {
        self.store = store
        collectionViewDataSource = SchulteTrainingCollectionViewDataSource()
        collectionViewDelegate = SchulteTrainingCollectionViewDelegate(store: store)
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

    override func customBackButtonDidTap() {
        store.dispatch(action: .didTapBackButton)
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .initial(viewModels, isInversed):
                self.collectionViewDataSource.viewModels = viewModels
                self.collectionView.reloadData()
                self.messageLabel.text = isInversed ? R.string.schulteTraining.concentrateInverseMessage() :
                    R.string.schulteTraining.concentrateMessage()
            case let .nextNumberUpdated(number):
                self.nextElementLabel.text = R.string.schulteTraining.next() + "\(number)"
            case let .updated(index, viewModels):
                self.collectionViewDataSource.viewModels = viewModels
                self.collectionView.performUsingPresentationValues {
                    self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                }
            case let .timerUpdated(formattedTime):
                self.timerLabel.text = formattedTime
            case let .configured(configuration):
                self.onBackButtonDidTap?(configuration)
            case let .finished(formattedTime):
                self.onTrainingDidFinish?(formattedTime)
            }
        }.store(in: &cancellables)
    }

    private func setupUI() {
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDataSource
        collectionView.register(cellClass: SchulteTrainingCell.self)
    }
}
