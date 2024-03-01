//
//  Created by sugurutakahashi on 2024/02/29
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct AppRootViewSnapshotTest {
    @Test @MainActor func previewAppRootView() {
        SnapshotConfig.previewTest(AppRootView_Previews.self)
    }

    /// デバイスバリエーションテストをしたい場合
    @Test @MainActor func previewDeviceVariationAppRootView() {
        SnapshotConfig.previewDeviceVariationTest(AppRootView_Previews.self)
    }

    /// 文字サイズのバリエーションテストをしたい場合
    @Test @MainActor func previewContentSizeVariationAppRootView() {
        SnapshotConfig.previewContentSizeVariationTest(AppRootView_Previews.self)
    }
}
