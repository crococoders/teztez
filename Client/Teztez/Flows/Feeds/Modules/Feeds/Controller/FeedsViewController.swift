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
    var onProfileButtonDidTap: Callback? { get set }
}

private enum Constants {
    static let ImageSizeForLargeState: CGFloat = 40
    static let ImageRightMargin: CGFloat = 16
    static let ImageBottomMarginForLargeState: CGFloat = 12
    static let ImageBottomMarginForSmallState: CGFloat = 6
    static let ImageSizeForSmallState: CGFloat = 32
    static let NavBarHeightSmallState: CGFloat = 44
    static let NavBarHeightLargeState: CGFloat = 96.5
}

// swiftlint:disable all
final class FeedsViewController: ViewController, FeedsPresentable {
    var onInformationSelected: ((_ details: InformationDetails) -> Void)?
    var onProfileButtonDidTap: Callback?

    private let store: FeedsStore
    private let collectionViewDataSource: FeedsCollectionViewDataSource
    private let collectionViewDelegate: FeedsCollectionViewDelegate
    private var cancellables = Set<AnyCancellable>()
    private let refreshControl = UIRefreshControl()
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.profileImage(), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(profileButtonDidTap), for: .touchUpInside)
        return button
    }()

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
        store.dispatch(action: .didLoadView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        setupProfileButton()
        profileButton.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        profileButton.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeProfileButton(for: height)
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
                let vc = InformationDetailsViewController(store: InformationDetailsStore(details: details))
                vc.modalPresentationStyle = .fullScreen
                vc.isHeroEnabled = true
                self.present(vc, animated: true)
            case .loading:
                self.indicatorView.startAnimating()
                self.indicatorView.isHidden = false
                self.collectionView.isHidden = true
            case .loaded:
                self.indicatorView.stopAnimating()
                self.collectionView.isHidden = false
                self.refreshControl.endRefreshing()
            }
        }.store(in: &cancellables)
    }

    private func setupNavigationBar() {
        guard let name = UserSession.shared.name else { return }
        navigationItem.title = "Hello! \(name)"
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

    private func setupProfileButton() {
        navigationController?.navigationBar.prefersLargeTitles = true

        guard let navigationBar = navigationController?.navigationBar else { return }

        navigationBar.addSubview(profileButton)

        profileButton.layer.cornerRadius = Constants.ImageSizeForLargeState / 2
        profileButton.clipsToBounds = true
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([profileButton.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Constants.ImageRightMargin),
                                     profileButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Constants.ImageBottomMarginForLargeState),
                                     profileButton.heightAnchor.constraint(equalToConstant: Constants.ImageSizeForLargeState),
                                     profileButton.widthAnchor.constraint(equalTo: profileButton.heightAnchor)])
    }

    private func moveAndResizeProfileButton(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Constants.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Constants.NavBarHeightLargeState - Constants.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()

        let factor = Constants.ImageSizeForSmallState / Constants.ImageSizeForLargeState

        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()

        let sizeDiff = Constants.ImageSizeForLargeState * (1.0 - factor)
        let yTranslation: CGFloat = {
            let maxYTranslation = Constants.ImageBottomMarginForLargeState - Constants.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, maxYTranslation - coeff * (Constants.ImageBottomMarginForSmallState + sizeDiff)))
        }()

        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)

        profileButton.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }

    @objc
    func refreshDidPull() {
        store.dispatch(action: .didForceRefresh)
    }

    @objc
    func profileButtonDidTap() {
        onProfileButtonDidTap?()
    }
}
