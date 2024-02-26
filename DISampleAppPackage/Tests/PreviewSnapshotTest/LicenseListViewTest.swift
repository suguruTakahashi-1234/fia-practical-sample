//
//  Created by sugurutakahashi on 2024/02/26
//  Copyright sugurutakahashi. All rights reserved.
//

import PreviewSnapshotsTesting
import XCTest
@testable import PresentationLayer

final class LicenseListViewTest: XCTestCase {
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
