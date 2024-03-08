//
//  Created by sugurutakahashi on 2024/02/26
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct LicenseDetailViewSnapshotTest {
    @Test @MainActor func previewLicenseDetailView() {
        SnapshotConfig.previewTest(LicenseDetailView_Previews.self)
    }

    /// デバイスバリエーションテストをしたい場合
    @Test @MainActor func previewDeviceVariationLicenseDetailView() {
        SnapshotConfig.previewDeviceVariationTest(LicenseDetailView_Previews.self)
    }

    /// 文字サイズのバリエーションテストをしたい場合
    @Test @MainActor func previewContentSizeVariationLicenseDetailView() {
        SnapshotConfig.previewContentSizeVariationTest(LicenseDetailView_Previews.self)
    }
}
