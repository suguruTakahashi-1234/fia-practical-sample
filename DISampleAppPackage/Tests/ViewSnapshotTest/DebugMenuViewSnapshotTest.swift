
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct DebugMenuViewSnapshotTest {
    @Test @MainActor func previewDebugMenuView() {
        SnapshotConfig.previewTest(DebugMenuView_Previews.self)
    }
}
