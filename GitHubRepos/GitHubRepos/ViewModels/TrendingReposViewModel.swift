//
//  TrendingReposViewModel.swift
//  GitHubRepos
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import Foundation

// Final View Object to set in UI
struct RepoViewData {
    let repoName: String
    let repoDescription: String
    let starsCount: Int
    let userName: String
    let avatarURL: String
}

class TrendingReposViewModel {
    // Variables holding the data
    private var repoModel: ReposModel?
    private var repoItems: [RepoItem] = []
    private var moreItemsAvailable: Bool = true
    private var currentPage: Int = 1

    // MARK: - Get Repo's list based on the Page number
    func getReposInformation(for pageNumber: Int, completionCallBack: @escaping(Bool, String?) -> Void) {
        APIClient.getReposList(pageNumber: pageNumber) { (isSuccess, error, modelData) in
            if isSuccess {
                if let dataItems = modelData?.repoItems {
                    self.repoItems.append(contentsOf: dataItems)
                    completionCallBack(true, nil)
                    return
                }
            }
            completionCallBack(false, error?.localizedDescription)
        }
    }

    // MARK: - Get Current Page
    func getCurrentPage() -> Int {
        return currentPage
    }

    // MARK: - Set Current PageNumber
    func setCurentPage(pageNumber: Int) {
        self.currentPage = pageNumber
    }

    // MARK: - Get the value of areMoreItemsAvailable to know if Items are available to load more data
    func areMoreItemsAvailable() -> Bool {
        return moreItemsAvailable
    }

    // MARK: - Set moreItemsAvailable value
    func setMoreItemsAvailable(moreItemsAvailable: Bool) {
        self.moreItemsAvailable = moreItemsAvailable
    }

    // MARK: - Get Number of sections for tableview
    func getSectionsCount() -> Int {
        return 1
    }

    // MARK: - Get number of Items available
    func getRepoItemsCount() -> Int {
        return repoItems.count
    }

    // MARK: - Get the current Item Details
    func getRepoItem(at position: Int) -> RepoViewData {
        RepoViewData(repoName: self.repoItems[position].repoName ?? "",
                     repoDescription: self.repoItems[position].repoDescription ?? "",
                     starsCount: self.repoItems[position].starsCount ?? 0,
                     userName: self.repoItems[position].ownerDetails?.userName ?? "",
                     avatarURL: self.repoItems[position].ownerDetails?.avatarURL ?? "" )
    }
}
