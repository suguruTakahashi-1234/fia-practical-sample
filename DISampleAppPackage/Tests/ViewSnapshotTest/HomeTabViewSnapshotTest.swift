
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct HomeTabViewSnapshotTest {
    @Test @MainActor func previewHomeTabView() {
        SnapshotConfig.previewTest(HomeTabView_Previews.self)
    }
}
