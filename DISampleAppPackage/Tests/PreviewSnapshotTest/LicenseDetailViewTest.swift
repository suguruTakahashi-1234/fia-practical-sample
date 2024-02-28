//
//  Created by sugurutakahashi on 2024/02/26
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite("ライセンス詳細画面 - スナップショットテスト") struct LicenseDetailViewSnapshotTest {
    @Test("プレビュー") @MainActor func previewLicenseDetailView() {
        SnapshotConfig.previewTest(LicenseDetailView_Previews.self)
    }
}
