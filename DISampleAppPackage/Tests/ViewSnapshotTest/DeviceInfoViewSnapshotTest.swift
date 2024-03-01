
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct DeviceInfoViewSnapshotTest {
    @Test @MainActor func previewDeviceInfoView() {
        SnapshotConfig.previewTest(DeviceInfoView_Previews.self)
    }
}
