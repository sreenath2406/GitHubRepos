//
//  RepoItem.swift
//  GitHubRepos
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import Foundation
struct RepoItem: Codable {
    let repoName: String?
    let repoDescription: String?
    let starsCount: Int?
    let ownerDetails: RepoOwner?

    enum CodingKeys: String, CodingKey {
        case repoName = "name"
        case repoDescription = "description"
        case starsCount = "watchers_count"
        case ownerDetails = "owner"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        repoName = try values.decodeIfPresent(String.self, forKey: .repoName)
        repoDescription = try values.decodeIfPresent(String.self, forKey: .repoDescription)
        starsCount = try values.decodeIfPresent(Int.self, forKey: .starsCount)
        ownerDetails = try values.decodeIfPresent(RepoOwner.self, forKey: .ownerDetails)
    }
}
