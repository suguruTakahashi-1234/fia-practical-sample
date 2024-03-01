
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct AppRootTabViewSnapshotTest {
    @Test @MainActor func previewAppRootTabView() {
        SnapshotConfig.previewTest(AppRootTabView_Previews.self)
    }
}
