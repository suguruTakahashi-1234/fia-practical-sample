//
//  Created by sugurutakahashi on 2024/03/08
//  Copyright sugurutakahashi. All rights reserved.
//

import XCTest

final class ProductionUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testTaskListView() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["タブバー"].buttons["タスク"].tap()
    }

    func testSettingView() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["タブバー"].buttons["設定"].tap()
    }

    func testLicenseListView() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["タブバー"].buttons["設定"].tap()
        app.collectionViews/*@START_MENU_TOKEN@*/ .staticTexts["ライセンス"]/*[[".cells",".buttons[\"ライセンス\"].staticTexts[\"ライセンス\"]",".staticTexts[\"ライセンス\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        app.navigationBars["ライセンス"].buttons["設定"].tap()
    }

    func testLicenseDetailView() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["タブバー"].buttons["設定"].tap()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/ .buttons["ライセンス"]/*[[".cells.buttons[\"ライセンス\"]",".buttons[\"ライセンス\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/ .buttons["abseil"]/*[[".cells.buttons[\"abseil\"]",".buttons[\"abseil\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
    }

    func testDeviveInfoView() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["タブバー"].buttons["設定"].tap()

        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/ .buttons["デバイス情報"]/*[[".cells.buttons[\"デバイス情報\"]",".buttons[\"デバイス情報\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/ .buttons["Build Scheme, Production"]/*[[".cells.buttons[\"Build Scheme, Production\"]",".buttons[\"Build Scheme, Production\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        app.alerts["Copied \"Production\""].scrollViews.otherElements.buttons["OK"].tap()
        app.navigationBars["デバイス情報"].buttons["設定"].tap()
    }
}
