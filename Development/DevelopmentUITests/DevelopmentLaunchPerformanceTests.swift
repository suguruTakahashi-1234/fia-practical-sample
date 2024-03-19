//
//  Created by sugurutakahashi on 2024/03/20
//  Copyright sugurutakahashi. All rights reserved.
//

import XCTest

final class DevelopmentLaunchPerformanceTests: XCTestCase {
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
