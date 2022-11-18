//
//  HomeControllerUITests.swift
//  FetchRewardsUITests
//
//  Created by LanceMacBookPro on 11/17/22.
//

import XCTest

class HomeControllerUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testNavigationItemTitleInHomeVC() {
        
        let app = XCUIApplication()
        
        let navTitleText = "Tap a Dessert"
        let predicate = NSPredicate(format: "label LIKE %@", navTitleText)
        let elementToEvaluate = app.staticTexts.element(matching: predicate)
        
        expectation(for: NSPredicate(format: "exists == 1", argumentArray: nil), evaluatedWith: elementToEvaluate, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }
}
