//
//  RepoOwner.swift
//  GitHubRepos
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import Foundation

struct RepoOwner: Codable {
    let userName: String?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case userName = "login"
        case avatarURL = "avatar_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        avatarURL = try values.decodeIfPresent(String.self, forKey: .avatarURL)
    }
}
