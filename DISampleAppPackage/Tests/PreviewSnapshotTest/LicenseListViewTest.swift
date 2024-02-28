//
//  Created by sugurutakahashi on 2024/02/26
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite("ライセンス詳細画面 - スナップショットテスト") struct LicenseListViewSnapshotTest {
    @Test("プレビュー") @MainActor func previewLicenseListView() {
        SnapshotConfig.previewTest(LicenseListView_Previews.self)
    }
    
    // デバイスバリエーションテストをしたい場合
    @Test("プレビュー - バリエーション - デバイス") @MainActor func previewDeviceVariationLicenseListView() {
        SnapshotConfig.deviceVariationTest(LicenseListView_Previews.self)
    }
    
    // 文字サイズのバリエーションテストをしたい場合
    @Test("プレビュー - バリエーション - 文字サイズ") @MainActor func previewContentSizeVariationLicenseListView() {
        SnapshotConfig.contentSizeVariationTest(LicenseListView_Previews.self)
    }
}
