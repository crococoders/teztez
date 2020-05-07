//
//  ColorMatchingTrainingViewController.swift
//  Teztez
//
//  Created by Adlet on 04/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol ColorMatchingTrainingPresentable: Presentable {
    var onBackButtonDidTap: ((_ configuration: ColorMatchingConfiguration) -> Void)? { get set }
    var onTrainingDidFinish: ((_ score: Int) -> Void)? { get set }
}

final class ColorMatchingTrainingViewController: ViewController, ColorMatchingTrainingPresentable {
    var onBackButtonDidTap: ((ColorMatchingConfiguration) -> Void)?
    var onTrainingDidFinish: ((Int) -> Void)?

    private let store: ColorMatchingTrainingStore
    private let collectionViewDataSource: ColorMatchingCollectionViewDataSource
    private let collectionViewDelegate: ColorMatchingCollectionViewDelegate
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var circleView: UIView!
    @IBOutlet private var pointsLabel: UILabel!
    @IBOutlet private var timerLabel: UILabel!
    @IBOutlet private var collectionView: UICollectionView!

    init(store: ColorMatchingTrainingStore) {
        self.store = store
        collectionViewDataSource = ColorMatchingCollectionViewDataSource()
        collectionViewDelegate = ColorMatchingCollectionViewDelegate(store: store)
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
            guard let self = self, let state = state else { return }
            switch state {
            case let .initial(gradientColors):
                self.collectionViewDataSource.gradientColors.removeAll()
                self.collectionViewDataSource.gradientColors.append(contentsOf: gradientColors)
                self.collectionView.performUsingPresentationValues {
                    self.collectionView.reloadData()
                }
            case let .updateScore(score):
                self.pointsLabel.text = "\(score)pt"
            case let .timerStarted(duration):
                self.timerLabel.text = duration
            case let .configured(configuration):
                self.onBackButtonDidTap?(configuration)
            case let .finished(score):
                self.onTrainingDidFinish?(score)
            }
        }.store(in: &cancellables)
    }

    private func setupProgress(with duration: TimeInterval) {}

    func setupUI() {
        circleView.layer.cornerRadius = circleView.frame.width / 2
        setupLocalization()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        collectionView.register(cellClass: BlockCell.self)
    }

    private func setupLocalization() {
        titleLabel.text = R.string.colorMatchingTraining.title()
    }

    override func customBackButtonDidTap() {
        store.dispatch(action: .didTapBackButton)
    }
}
