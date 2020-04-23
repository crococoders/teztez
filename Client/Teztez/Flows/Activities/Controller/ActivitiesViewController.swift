//
//  ActivitiesViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol ActivitiesPresentable: Presentable {
    var onItemDidSelect: ((_ indexPath: Int) -> Void)? { get set }
}

final class ActivitiesViewController: UIViewController, ActivitiesPresentable {
    var onItemDidSelect: ((Int) -> Void)?

    private let store: ActivitiesStore

    init(store: ActivitiesStore) {
        self.store = store
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.activities.navigationTitle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .black
    }

    private func setupNavigationBar() {}
}
