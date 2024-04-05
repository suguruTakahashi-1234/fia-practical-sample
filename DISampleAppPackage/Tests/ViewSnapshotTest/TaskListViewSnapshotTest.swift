
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct TaskListViewSnapshotTest {
    @Test @MainActor func previewTest() {
        SnapshotConfig.previewTest(TaskListView_Previews.self, shouldWait: true)
    }
}
