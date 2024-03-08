
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct TaskListViewSnapshotTest {
    @Test @MainActor func previewTaskListView() {
        SnapshotConfig.previewTest(TaskListView_Previews.self)
    }
}
