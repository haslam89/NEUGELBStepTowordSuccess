//
//  MovieDBUITests.swift
//  MovieDBUITests
//
//  Created by Hassan Jaffri on 13/11/2025.
//

import XCTest

final class MovieDBUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    @MainActor
    func testMoviesListLoads() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.navigationBars["Movies"].exists)
        XCTAssertTrue(app.scrollViews.firstMatch.exists)
    }
    override func tearDownWithError() throws {

    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
