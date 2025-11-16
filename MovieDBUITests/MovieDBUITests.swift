//
//  MovieDBUITests.swift
//  MovieDBUITests
//
//  Created by Hassan Jaffri on 13/11/2025.
//

import XCTest

final class MovieDBUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    @MainActor
    func testMoviesListLoads() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.navigationBars["Movies"].exists)
        XCTAssertTrue(app.scrollViews.firstMatch.exists)
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
