//
//  APIClient.swift
//  GitHubRepos
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    // MARK: - Get the Repos list based on the pageNumber
    static func getReposList(pageNumber: Int, completionCallBack: @escaping(Bool, Error?, ReposModel?) -> Void) {
        let headers: HTTPHeaders = ["Accept": "application/json"]
        let reposURL = GitHubRepoUrl(path: .getRepos(page: pageNumber)).url
        AF.request(reposURL, method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON { (responseObject) in
                    switch responseObject.result {
                    case .success(_):
                        do {
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(ReposModel.self, from: responseObject.data!)
                            completionCallBack(true, nil, responseModel)
                        } catch let error {
                            completionCallBack(false, error, nil)
                        }
                    case .failure(let error):
                        completionCallBack(false, error, nil)
                    }
        }
    }
}
