//
//  GitHubReposUITests.swift
//  GitHubReposUITests
//
//  Created by Sreenath reddy Bollam on 27/11/19.
//  Copyright © 2019 SreenathReddy. All rights reserved.
//

import XCTest

class GitHubReposUITests: XCTestCase {

    var application: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
        /*
         In UI tests it’s important to set the initial state
                - such as interface orientation
                - required for your tests before they run.
         The setUp method is a good place to do this.
        */
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsUITableViewEnabled() {
        let trendingReposTableView = application.tables[StaticString.tableViewIdentifier]
        XCTAssertTrue(trendingReposTableView.isEnabled, "TrendingReposTableView should be available in ViewControllers")
    }

    func testIsUITableViewCellExists() {
        let cellContainer = application.tables[StaticString.tableViewIdentifier].cells.element(boundBy: 1)
        if cellContainer.waitForExistence(timeout: 10) {
            XCTAssertTrue(cellContainer.exists, "TrendingReposTableView Cell should contain a cell")
        } else {
            XCTFail("TrendingReposTableView Cell Not available")
        }
    }

    func testIsUITableViewCellWithRepoNameExists() {
        let cellContainer = application.tables[StaticString.tableViewIdentifier].cells.element(boundBy: 1)
        if cellContainer.waitForExistence(timeout: 10) {
            let repoNameLbl = cellContainer.staticTexts[StaticString.repositoryNameIdentifier]
            XCTAssertTrue(repoNameLbl.exists, "TrendingReposTableView Cell should contain Repo Name")
        } else {
            XCTFail("TrendingReposTableView Cell Not available")
        }
    }

    func testIsUITableViewCellWithRepoDescExists() {
           let cellContainer = application.tables[StaticString.tableViewIdentifier].cells.element(boundBy: 1)
           if cellContainer.waitForExistence(timeout: 10) {
               let repoNameLbl = cellContainer.staticTexts[StaticString.repositoryDescIdentifier]
               XCTAssertTrue(repoNameLbl.exists, "TrendingReposTableView Cell should contain Repo Desc")
           } else {
               XCTFail("TrendingReposTableView Cell Not available")
           }
       }
}
