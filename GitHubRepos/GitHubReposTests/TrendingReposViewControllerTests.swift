//
//  TrendingReposViewControllerTests.swift
//  GitHubReposTests
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import XCTest
@testable import GitHubRepos

class TrendingReposViewControllerTests: XCTestCase {

    var mockTrendingReposViewController: GitHubRepos.TrendingReposViewController?
    let mockTrendingReposViewModel = TrendingReposViewModel()
    var mockTableView: UITableView!

    override func setUp() {
        // Load the JSON
        let bundle = Bundle(for: TrendingReposViewModelTests.self)
        guard let filePath = bundle.path(forResource: "MockRepoDataModel", ofType: "json") else {
            return XCTFail("Unable to locate MockRepoDataModel JSON")
        }
        let pathURL = URL(fileURLWithPath: filePath)
        guard let mockData = try? Data(contentsOf: pathURL) else {
            return XCTFail("Unable to get Data from MockRepoDataModel JSON")
        }
        let jsonDecoder = JSONDecoder()
        guard let mockRepoData = try? jsonDecoder.decode(ReposModel.self, from: mockData) else {
            return XCTFail("Cannot convert MockRepoDataModel Data to Repo Object")
        }
        mockTrendingReposViewModel.repoItems = mockRepoData.repoItems

        // Load UI Elements
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        self.mockTrendingReposViewController = storyboard.instantiateViewController(withIdentifier:
                            "TrendingReposViewController")
            as? GitHubRepos.TrendingReposViewController
        if mockTrendingReposViewController == nil {
            return XCTFail("Cannot load TrendingReposViewController")
        }
        self.mockTrendingReposViewController?.viewDidLoad()
        mockTableView = self.mockTrendingReposViewController?.reposTableView
    }

    func testHasTrendingReposTableView() {
        XCTAssertNotNil(self.mockTrendingReposViewController!.reposTableView)
    }

    func testTrendingReposTableViewHasDataSource() {
        XCTAssertNotNil(self.mockTrendingReposViewController!.reposTableView.dataSource, "DataSource is not set")
    }

    func testTrendingReposTableViewHasDelegate() {
        XCTAssertNotNil(self.mockTrendingReposViewController!.reposTableView.delegate, "Delgate is not set")
    }

    func testTrendingReposTableTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(self.mockTrendingReposViewController!.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(self.mockTrendingReposViewController!.responds(to:
            #selector(self.mockTrendingReposViewController!.numberOfSections(in:))))
        XCTAssertTrue(self.mockTrendingReposViewController!.responds(to:
            #selector(self.mockTrendingReposViewController!.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(self.mockTrendingReposViewController!.responds(to:
            #selector(self.mockTrendingReposViewController!.tableView(_:cellForRowAt:))))
    }

    func testNumberOfSectionsForReposTableViewShoudReturtn1() {
        XCTAssertTrue(self.mockTrendingReposViewController!.numberOfSections(in: mockTableView) == 1,
                      "Number of Sections should return 1")
    }
}
