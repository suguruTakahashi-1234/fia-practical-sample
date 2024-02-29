//
//  Created by sugurutakahashi on 2024/02/26
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct LicenseListViewSnapshotTest {
    @Test @MainActor func previewLicenseListView() {
        SnapshotConfig.previewTest(LicenseListView_Previews.self)
    }

    /// デバイスバリエーションテストをしたい場合
    @Test @MainActor func previewDeviceVariationLicenseListView() {
        SnapshotConfig.previewDeviceVariationTest(LicenseListView_Previews.self)
    }

    /// 文字サイズのバリエーションテストをしたい場合
    @Test @MainActor func previewContentSizeVariationLicenseListView() {
        SnapshotConfig.previewContentSizeVariationTest(LicenseListView_Previews.self)
    }
}
