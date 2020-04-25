//
//  ViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CoordinatorNavigationControllerDelegate {
    override var prefersStatusBarHidden: Bool { return false }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCoordinatorNavigationController()
    }

    func setupCoordinatorNavigationController() {
        guard let navigationController = navigationController as? CoordinatorNavigationController else { return }
        navigationController.coordinatorNavigationDelegate = self
    }

    func transitionBackDidFinish() {}
    func customBackButtonDidTap() {}
}
