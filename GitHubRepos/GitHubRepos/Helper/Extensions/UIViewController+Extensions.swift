//
//  UIViewController+Extensions.swift
//  GitHubRepos
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    /*
        To show a dialog with Ok button
     */
    public func showErrorDialog(with title: String, message: String) {
        let alertDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertDialog.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertDialog, animated: true)
    }

    /*
     Show Loading View
     */
    public func showLoadingView() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }

    /*
     Hide LoadingView
     */
    public func hideLoadingView() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
