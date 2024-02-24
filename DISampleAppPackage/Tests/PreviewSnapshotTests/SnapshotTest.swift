//
//  Created by sugurutakahashi on 2024/02/21
//  Copyright sugurutakahashi. All rights reserved.
//

import PreviewSnapshotsTesting
import PreviewSnapshots
import XCTest
@testable import PresentationLayer

final class SnapshotTest: XCTestCase {
    func testAppRootView() {
        SnapshotConfig.previewTest(AppRootView_Previews.self)
    }
    
    func testLicenseListView() {
        SnapshotConfig.previewTest(LicenseListView_Previews.self)
        
        // デバイスバリエーションテストをしたい場合
        SnapshotConfig.deviceVariationTest(LicenseListView_Previews.self)
        
        // 文字サイズのバリエーションテストをしたい場合
        SnapshotConfig.contentSizeVariationTest(LicenseListView_Previews.self)
    }

    func testLicenseDetailView() {
        SnapshotConfig.previewTest(LicenseDetailView_Previews.self)
    }
}
