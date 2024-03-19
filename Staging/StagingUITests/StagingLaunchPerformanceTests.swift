//
//  Created by sugurutakahashi on 2024/03/20
//  Copyright sugurutakahashi. All rights reserved.
//

import XCTest

final class StagingLaunchPerformanceTests: XCTestCase {
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
