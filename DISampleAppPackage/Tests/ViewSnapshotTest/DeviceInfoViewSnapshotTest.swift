
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct DeviceInfoViewSnapshotTest {
    @Test @MainActor func previewTest() {
        SnapshotConfig.previewTest(DeviceInfoView_Previews.self)
    }

    /// デバイスバリエーションテストをしたい場合
    @Test @MainActor func previewDeviceVariationTest() {
        SnapshotConfig.previewDeviceVariationTest(DeviceInfoView_Previews.self)
    }

    /// 文字サイズのバリエーションテストをしたい場合
    @Test @MainActor func previewContentSizeVariationTest() {
        SnapshotConfig.previewContentSizeVariationTest(DeviceInfoView_Previews.self)
    }

    /// ダークモードでテストしたい場合
    @Test @MainActor func previewDarkModeTest() {
        SnapshotConfig.previewDarkModeTest(DeviceInfoView_Previews.self)
    }

    /// 多言語テストしたい場合
    @Test @MainActor func previewLanguageVariationTest() {
        SnapshotConfig.previewLanguageVariationTest(DeviceInfoView_Previews.self)
    }
}
