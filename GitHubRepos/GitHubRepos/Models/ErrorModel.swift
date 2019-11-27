//
//  ErrorModel.swift
//  GitHubRepos
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import Foundation
struct ErrorModel {
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case errorMessage = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
    }
}
