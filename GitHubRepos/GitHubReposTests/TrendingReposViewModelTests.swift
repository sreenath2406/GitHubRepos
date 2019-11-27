//
//  TrendingReposViewModelTests.swift
//  GitHubReposTests
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import XCTest

class TrendingReposViewModelTests: XCTestCase {

    let mockTrendingReposViewModel = TrendingReposViewModel()
    override func setUp() {
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
    }

    override func tearDown() {
    }

    func testGetCurrentPageMethod() {
        mockTrendingReposViewModel.setCurentPage(pageNumber: 1)
        XCTAssertTrue(mockTrendingReposViewModel.getCurrentPage() == 1,
                      "Current Page Should return 1 as we've set to 1")
    }

    func testAreMoreItemsAvailableShouldReturnTrueIfSeetToTrue() {
        mockTrendingReposViewModel.setMoreItemsAvailable(moreItemsAvailable: true)
        XCTAssertTrue(mockTrendingReposViewModel.areMoreItemsAvailable(),
                      "moreItemsAvailable should return true")
    }

    func testAreMoreItemsAvailableShouldReturnFalseIfSeetToFalse() {
        mockTrendingReposViewModel.setMoreItemsAvailable(moreItemsAvailable: false)
        XCTAssertFalse(mockTrendingReposViewModel.areMoreItemsAvailable(),
                       "moreItemsAvailable should return false")
    }

    func testGetNumberOfSectionsShouldAlwaysReturnOne() {
        XCTAssertTrue(mockTrendingReposViewModel.getSectionsCount() == 1,
                      "getNumberOfSections should always return 1")
    }

    func testgetRepoItemsCountShouldReturnCountFromMockJsonData() {
        XCTAssertTrue(mockTrendingReposViewModel.getRepoItemsCount() == 2,
                      "getRepoItemsCount should return 2 as the mock json has two elements")
    }

    func testgetRepoItemAtPosition0ShouldReturnSameAsMockData() {
        let mockDataAtPosition0 = mockTrendingReposViewModel.getRepoItem(at: 0)
        XCTAssertEqual(mockDataAtPosition0.repoName, "ImmortalDB",
                       "RepoName at position 0 should return as ImmortalDB as per the MockJSON")
        XCTAssertEqual(mockDataAtPosition0.repoDescription, "A relentless key-value store for the browser.",
                       "RepoDescription at position 0 should return as per the MockJSON")
        XCTAssertEqual(mockDataAtPosition0.starsCount, 2516,
                       "StarsCount should return 1346 as per the MockJSON")
    }
}
