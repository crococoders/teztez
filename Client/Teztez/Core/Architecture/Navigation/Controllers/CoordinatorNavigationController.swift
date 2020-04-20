//
//  CoordinatorNavigationController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol CoordinatorNavigationControllerDelegate: class {
    func transitionBackDidFinish()
    func customBackButtonDidTap()
}

final class CoordinatorNavigationController: UINavigationController {
    weak var coordinatorNavigationDelegate: CoordinatorNavigationControllerDelegate?

    private var isPushBeingAnimated = false

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    func setupBackButton(viewController: UIViewController) {
        viewController.navigationItem.hidesBackButton = true
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-icon"),
                                                                          style: .done,
                                                                          target: self,
                                                                          action: #selector(backButtonDidTap))
    }

    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        isPushBeingAnimated = true
        super.pushViewController(viewController, animated: animated)
        setupBackButton(viewController: viewController)
    }

    func enableSwipeBack() {
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
    }

    @objc private func backButtonDidTap() {
        coordinatorNavigationDelegate?.customBackButtonDidTap()
    }
}

extension CoordinatorNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let coordinator = navigationController.topViewController?.transitionCoordinator else { return }
        coordinator.notifyWhenInteractionChanges { [weak self] context in
            guard !context.isCancelled else { return }
            self?.coordinatorNavigationDelegate?.transitionBackDidFinish()
        }
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? CoordinatorNavigationController else { return }
        swipeNavigationController.isPushBeingAnimated = false
    }
}

extension CoordinatorNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else { return true }
        return viewControllers.count > 1 && isPushBeingAnimated == false
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
