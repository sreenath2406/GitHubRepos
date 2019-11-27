//
//  GitHubRepoURL.swift
//  GitHubRepos
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import Foundation

struct GitHubRepoUrl {

    // Path to URL's
    enum Path {
        case getRepos(page: Int)

        fileprivate var components: String {
            switch self {
            case let .getRepos(page):
                return "?q=created:%3E2017-10-22&sort=stars&order=desc&page=\(page)"
            }
        }
    }

    private let path: Path

    // Base URL
    private var baseURL: String {
        return "https://api.github.com/search/repositories"
    }
    
    // Path
    init(path: Path) {
        self.path = path
    }

    //Final URL to call the API's
    var url: URL {
        let string = "https://\(baseURL)/\(path.components)"
        guard let url = URL(string: string) else { fatalError("URL conversion failed") }
        return url
    }
}
