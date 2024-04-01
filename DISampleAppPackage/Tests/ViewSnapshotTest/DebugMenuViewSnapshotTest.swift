
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct DebugMenuViewSnapshotTest {
    @Test @MainActor func previewTest() {
        SnapshotConfig.previewTest(DebugMenuView_Previews.self)
    }
}
