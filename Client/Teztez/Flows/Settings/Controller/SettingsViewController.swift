//
//  SettingsViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 09/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol SettingsPresentable: Presentable {
    var onBackButtonTap: Callback? { get set }
}

final class SettingsViewController: ViewController, SettingsPresentable {
    var onBackButtonTap: Callback?

    private let store: SettingsStore
    private let tableViewDelegate: SettingsTableViewDelegate
    private let tableViewDataSource: SettingsTableViewDataSource
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private var tableView: UITableView!

    init(store: SettingsStore) {
        self.store = store
        tableViewDataSource = SettingsTableViewDataSource()
        tableViewDelegate = SettingsTableViewDelegate(store: store)
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
        store.dispatch(action: .didViewLoad)
    }

    override func customBackButtonDidTap() {
        onBackButtonTap?()
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .initial(sections):
                self.tableViewDataSource.sections = sections
                self.tableViewDelegate.sections = sections
                self.tableView.reloadData()
            case .navigateToPrivacyPolicy:
                let vc = PrivacyPolicyViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            case .navigateToTermsOfConditions:
                let vc = TermsAndConditionsViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }.store(in: &cancellables)
    }

    private func setupUI() {
        setupTableView()
        setupNavigationBar()
    }

    private func setupTableView() {
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        [SettingsProfileCell.self, SettingsWebCell.self].forEach { tableView.register(cellClass: $0) }
    }

    private func setupNavigationBar() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
