//
//  UIViewController+Extensions.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/9/25.
//

import UIKit

extension UIViewController {
    func showErrorAlert(error: AppError) {
        let alert = UIAlertController(
            title: error.alertType.alertTitle,
            message: error.errorDescription,
            preferredStyle: .alert
        )

        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
}
