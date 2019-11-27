//
//  ReposModel.swift
//  GitHubRepos
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import Foundation
struct ReposModel: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let repoItems: [RepoItem]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case repoItems = "items"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try values.decode(Int.self, forKey: .totalCount)
        incompleteResults = try values.decode(Bool.self, forKey: .incompleteResults)
        repoItems = try values.decode([RepoItem].self, forKey: .repoItems)
    }
}
