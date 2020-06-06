//
//  ColorMatchingTrainingViewController.swift
//  Teztez
//
//  Created by Adlet on 04/06/2020.
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
    @IBOutlet private var progressView: ProgressView!
    @IBOutlet private var circleView: UIView!
    @IBOutlet private var pointsLabel: UILabel!
    @IBOutlet private var timerLabel: UILabel!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var leftConstraint: NSLayoutConstraint!

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
            case let .initial(viewModel: viewModels):
                self.collectionViewDataSource.viewModels = viewModels
                self.collectionView.reloadData()
            case let .updated(index, viewModels):
                self.collectionViewDataSource.viewModels = viewModels
                self.collectionView.performUsingPresentationValues {
                    self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                }
            case let .updateScore(score):
                self.pointsLabel.text = "\(score)pt"
            case let .timerStarted(duration):
                self.timerLabel.text = duration
            case let .updateProgress(duration):
                self.updateProgress(withDuration: TimeInterval(duration))
            case let .configured(configuration):
                self.onBackButtonDidTap?(configuration)
                self.navigationController?.popViewController(animated: true)
            case let .finished(score: score):
                let store = ColorMatchingResultStore(score: score)
                let viewController = ColorMatchingResultViewController(store: store)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }.store(in: &cancellables)
    }

    func setupUI() {
        circleView.layer.cornerRadius = circleView.frame.width / 2
        progressView.layer.cornerRadius = 2
        titleLabel.text = R.string.colorMatchingTraining.title()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        collectionView.register(cellClass: BlockCell.self)
    }

    private func updateProgress(withDuration duration: TimeInterval) {
        view.layoutIfNeeded()
        leftConstraint.constant = 20
        UIView.animate(withDuration: duration) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }

    override func customBackButtonDidTap() {
        store.dispatch(action: .didTapBackButton)
    }
}
