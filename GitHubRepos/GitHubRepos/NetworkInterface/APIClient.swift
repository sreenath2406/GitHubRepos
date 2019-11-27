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
                    let jsonDecoder = JSONDecoder()
                    switch responseObject.result {
                    case .success(_):
                        do {
                            // Check if we received any limit reached message
                            if let jsonData = try JSONSerialization.jsonObject(with: responseObject.data!,
                                                                               options: .allowFragments) as? [String: Any] {
                                if let errorMessage = jsonData["message"] as? String {
                                    let error = NSError(domain: "",
                                                        code: 500,
                                                        userInfo: [NSLocalizedDescriptionKey: errorMessage])
                                    completionCallBack(false, error, nil)
                                    return
                                }
                            }
                            // If there is no limit reached warning and we received data.
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
