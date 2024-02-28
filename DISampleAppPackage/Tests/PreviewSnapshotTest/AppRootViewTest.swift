//
//  Created by sugurutakahashi on 2024/02/21
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import XCTest

final class AppRootViewTest: XCTestCase {
    func testAppRootView() {
        SnapshotConfig.previewTest(AppRootView_Previews.self)
    }
}
