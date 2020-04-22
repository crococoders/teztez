//
//  TabBarController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol TabBarPresentable: Presentable {
    var onActivitiesTabDidSelect: ((CoordinatorNavigationController) -> Void)? { get set }
    var onViewDidLoad: ((CoordinatorNavigationController) -> Void)? { get set }
}

final class TabBarController: UITabBarController, TabBarPresentable {
    var onViewDidLoad: ((CoordinatorNavigationController) -> Void)?
    var onActivitiesTabDidSelect: ((CoordinatorNavigationController) -> Void)? {
        didSet {
            callOnViewDidLoadCallback()
        }
    }

    private lazy var activitiesNavigationController: CoordinatorNavigationController = {
        let navigationController = CoordinatorNavigationController()
        navigationController.title = R.string.mainTabBar.activitiesTitle()
        navigationController.tabBarItem.image = R.image.activities()
        return navigationController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        callOnViewDidLoadCallback()
    }

    private func setup() {
        delegate = self
        tabBar.tintColor = .accentBlue
        tabBar.barTintColor = .systemGray
        tabBar.unselectedItemTintColor = .systemGray4
        tabBar.isTranslucent = false
        viewControllers = [activitiesNavigationController]
    }

    private func callOnViewDidLoadCallback() {
        guard let controller = customizableViewControllers?.first as? CoordinatorNavigationController else { return }
        onViewDidLoad?(controller)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationController = viewControllers?[selectedIndex] as? CoordinatorNavigationController else { return }
        switch selectedIndex {
        case 0:
            onActivitiesTabDidSelect?(navigationController)
        default:
            break
        }
    }
}
