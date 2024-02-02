//
//  UIViewController+Extension.swift
//  MoviedbAPI
//
//  Created by Денис Харына on 02.02.2024.
//

import UIKit

extension UIViewController {
    func presentErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        present(alert, animated: true)
    }
}
