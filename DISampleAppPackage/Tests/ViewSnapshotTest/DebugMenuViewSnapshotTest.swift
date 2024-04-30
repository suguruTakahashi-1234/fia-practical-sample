
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct DebugMenuViewSnapshotTest {
    @Test @MainActor func previewTest() {
        SnapshotConfig.previewTest(DebugMenuView_Previews.self)
    }

    /// 多言語テストしたい場合
    @Test @MainActor func previewLanguageVariationTest() {
        SnapshotConfig.previewLanguageVariationTest(DebugMenuView_Previews.self)
    }
}
