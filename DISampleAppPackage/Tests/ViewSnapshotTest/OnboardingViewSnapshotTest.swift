
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct OnboardingViewSnapshotTest {
    @Test @MainActor func previewTest() {
        SnapshotConfig.previewTest(OnboardingView_Previews.self)
    }
}
