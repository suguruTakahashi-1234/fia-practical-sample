//
//  Created by sugurutakahashi on 2024/02/21
//  Copyright sugurutakahashi. All rights reserved.
//

import PreviewSnapshotsTesting
import XCTest
@testable import PresentationLayer

final class AppRootViewTest: XCTestCase {
    func testAppRootView() {
        SnapshotConfig.previewTest(AppRootView_Previews.self)
    }
}
