//
//  Created by sugurutakahashi on 2024/04/30
//  Copyright sugurutakahashi. All rights reserved.
//

import XCTest

final class DevelopmentViewCatalogUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLicenselist() throws {
        let app = XCUIApplication()
        app.launch()

        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/ .staticTexts["ライセンス一覧"]/*[[".cells",".buttons[\"ライセンス一覧\"].staticTexts[\"ライセンス一覧\"]",".staticTexts[\"ライセンス一覧\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/ .buttons["normal"]/*[[".cells.buttons[\"normal\"]",".buttons[\"normal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/ .buttons["abc123あいう漢字カナ"]/*[[".cells.buttons[\"abc123あいう漢字カナ\"]",".buttons[\"abc123あいう漢字カナ\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        app.navigationBars["abc123あいう漢字カナ"]/*@START_MENU_TOKEN@*/ .buttons["閉じる"]/*[[".otherElements[\"閉じる\"].buttons[\"閉じる\"]",".buttons[\"閉じる\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()

        let licenselistviewButton = app.navigationBars["ライセンス"].buttons["LicenseListView"]
        licenselistviewButton.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/ .buttons["empty"]/*[[".cells.buttons[\"empty\"]",".buttons[\"empty\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        licenselistviewButton.tap()
        app.navigationBars["LicenseListView"].buttons["View Catalog"].tap()
    }
}
