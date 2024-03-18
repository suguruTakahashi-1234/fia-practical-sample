
@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct OnboardingViewSnapshotTest {
    @Test @MainActor func previewOnboardingView() {
        SnapshotConfig.previewTest(OnboardingView_Previews.self)
    }
}
