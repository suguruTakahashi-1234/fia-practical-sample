
import PreviewSnapshotsTesting
import XCTest
@testable import PresentationLayer

final class SettingViewTest: XCTestCase {
    func testSettingView() {
        SnapshotConfig.previewTest(SettingView_Previews.self)
    }
}
