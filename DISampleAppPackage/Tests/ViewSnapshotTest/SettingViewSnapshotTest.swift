
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct SettingViewSnapshotTest {
    @Test @MainActor func previewSettingView() {
        SnapshotConfig.previewTest(SettingView_Previews.self)
    }
}
