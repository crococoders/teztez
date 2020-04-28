//
//  RouterImp.swift
//  Altel
//
//  Created by Almas Zainoldin on 4/1/20.
//  Copyright © 2020 Azimut Labs. All rights reserved.
//

import UIKit

typealias Callback = () -> Void

final class Router: Presentable {
    private weak var rootController: CoordinatorNavigationController?
    private var completions: [UIViewController: Callback] = [:]

    init(rootController: CoordinatorNavigationController) {
        self.rootController = rootController
    }

    func toPresent() -> UIViewController? {
        return rootController
    }

    func show(_ module: Presentable?, with transitionType: TransitionType) {
        guard let controller = module?.toPresent() else { return }
        switch transitionType {
        case .push:
            push(controller, animated: true, hideBottomBar: false, completion: nil)
        case .presentInFullScreen:
            present(controller, animated: true, modalPresentationStyle: .fullScreen)
        case let .presentInSheet(dismissable):
            controller.isModalInPresentation = !dismissable
            present(controller, animated: true, modalPresentationStyle: .pageSheet)
        }
    }

    func dismissModule(animated: Bool = true, completion: Callback? = nil) {
        rootController?.dismiss(animated: animated, completion: completion)
    }

    func popModule(animated: Bool = true) {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool = false) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }

    private func push(_ controller: UIViewController, animated: Bool, hideBottomBar: Bool, completion: Callback?) {
        guard controller is UINavigationController == false else {
            assertionFailure("Pushing UINavigationController is not allowed.")
            return
        }
        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.enableSwipeBack()
        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(controller, animated: animated)
    }

    private func present(_ controller: UIViewController, animated: Bool, modalPresentationStyle: UIModalPresentationStyle) {
        controller.modalPresentationStyle = modalPresentationStyle
        rootController?.present(controller, animated: animated, completion: nil)
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
