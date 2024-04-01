
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct HomeTabViewSnapshotTest {
    @Test @MainActor func previewTest() {
        SnapshotConfig.previewTest(HomeTabView_Previews.self)
    }
}
