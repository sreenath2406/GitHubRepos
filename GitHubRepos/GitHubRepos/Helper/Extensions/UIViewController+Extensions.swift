//
//  UIViewController+Extensions.swift
//  GitHubRepos
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import UIKit

extension UIViewController {
    /*
        To show a dilog with Ok button
     */
    public func showErrorDialog(with title: String, message: String) {
        let alertDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertDialog.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertDialog, animated: true)
    }
}
