//
//  TrendingReposCell.swift
//  GitHubRepos
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import UIKit
import Kingfisher
class TrendingReposCell: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var repoUserName: UILabel!
    @IBOutlet weak var repoStars: UILabel!
    @IBOutlet weak var repoUserAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setViewIdentifiers()
        self.repoUserAvatar.makeRoundedView()
    }

    // MARK: - View IDentifiers
    private func setViewIdentifiers() {
        self.accessibilityIdentifier = StaticString.tableViewCellIdentifier
        self.repoName.accessibilityIdentifier = StaticString.repositoryNameIdentifier
        self.repoDescription.accessibilityIdentifier = StaticString.repositoryDescIdentifier
        self.repoUserName.accessibilityIdentifier = StaticString.repositoryUserNameIdentifier
        self.repoStars.accessibilityIdentifier = StaticString.repositoryStarsIdentifier
    }
    // MARK: - Set the Repo Data to row.
    public func setRepoData(repoData: RepoViewData) {
        self.repoName.text = repoData.repoName
        self.repoDescription.text = repoData.repoDescription
        self.repoStars.text = String(format: "%d", repoData.starsCount)
        self.repoUserName.text = repoData.userName
        if let avatarURL = URL(string: repoData.avatarURL) {
            self.repoUserAvatar.kf.setImage(with: avatarURL)
        }
    }
}
