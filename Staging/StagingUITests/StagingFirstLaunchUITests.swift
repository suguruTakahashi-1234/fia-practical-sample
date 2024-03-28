//
//  Created by sugurutakahashi on 2024/03/28
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import XCTest

final class StagingFirstLaunchUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append(Constants.Arguments.firstLaunchUITest)
        app.launch()
    }

    func testFirstLaunch() throws {
        app.buttons["次へ"].tap()
        app.buttons["始める"].tap()
    }
}
