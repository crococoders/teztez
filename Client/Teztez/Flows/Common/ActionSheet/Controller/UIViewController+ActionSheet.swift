//
//  UIViewController+AlertSheet.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/29/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UIViewController {
    func showActionSheet(with viewModel: ActionSheetViewModel, cancelHandler: @escaping Callback) {
        let alertController = UIAlertController(title: viewModel.title, message: nil, preferredStyle: .actionSheet)
        alertController.overrideUserInterfaceStyle = .dark

        let cancelAction = UIAlertAction(title: viewModel.cancelTitle, style: .default) { _ in
            cancelHandler()
        }
        let continueAction = UIAlertAction(title: viewModel.continueTitle, style: .cancel)

        alertController.addAction(cancelAction)
        alertController.addAction(continueAction)
        present(alertController, animated: true)
    }
}
