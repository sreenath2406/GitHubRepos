//
//  ViewController.swift
//  GitHubRepos
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import UIKit

class TrendingReposViewController: UIViewController {
    @IBOutlet weak var reposTableView: UITableView!
    // ViewModel Objectr
    let trendingReposVM = TrendingReposViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoadingView()
        self.title = TrendingReposViewController.pageTitle
        registerTableViewCells()
        fetchReposInfo()
    }

    // MARK: Fetch Repo's Data from Server
    private func fetchReposInfo() {
        let currentPage = self.trendingReposVM.getCurrentPage()
        self.trendingReposVM.getReposInformation(for: currentPage + 1) {(isSuccess, error) in
            self.hideLoadingView()
            if isSuccess {
                // Reload TableView
                self.trendingReposVM.setCurentPage(pageNumber: currentPage + 1)
                self.reposTableView.reloadData()
            } else {
                // Show Error Dialog
                self.showErrorDialog(with: TrendingReposViewController.errorTitle,
                                     message: error ?? TrendingReposViewController.errorMessage)
                // Hide TableView footer
                self.reposTableView.tableFooterView?.isHidden = true
            }
        }
    }
    // MARK: Register TableView Cells
    private func registerTableViewCells() {
        self.reposTableView.register(UINib(nibName: "TrendingReposCell", bundle: .main),
                                     forCellReuseIdentifier: TrendingReposViewController.reposCellIdentifier)
        self.reposTableView.dataSource = self
        self.reposTableView.delegate = self
        self.reposTableView.tableFooterView = UIView()
        self.reposTableView.accessibilityIdentifier = TrendingReposViewController.tableViewIdentifier
    }
}

/*
 TrendingReposViewController extension for UITableView
 */
extension TrendingReposViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.trendingReposVM.getSectionsCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trendingReposVM.getRepoItemsCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingReposViewController.reposCellIdentifier)
            as? TrendingReposCell else {
                return UITableViewCell()
        }
        //Set the Data to UI
        cell.setRepoData(repoData: self.trendingReposVM.getRepoItem(at: indexPath.row))
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndexPath = self.trendingReposVM.getRepoItemsCount() - 1
        if indexPath.row == lastIndexPath && self.trendingReposVM.areMoreItemsAvailable() {
            let loadingView = UIActivityIndicatorView(style: .medium)
            loadingView.startAnimating()
            loadingView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
            self.reposTableView.tableFooterView = loadingView
            self.reposTableView.tableFooterView?.isHidden = false
            self.fetchReposInfo()
        }
    }
}

/*
 TrendingReposViewController extension for Static Strings
 */
extension TrendingReposViewController {
    static let pageTitle = "Trending Repos"
    static let reposCellIdentifier = "TrendingReposCell"
    static let errorTitle = "Error"
    static let errorMessage = "Unable to fetch the repo's list"
    static let tableViewIdentifier = "TrendingReposTableView"
}
