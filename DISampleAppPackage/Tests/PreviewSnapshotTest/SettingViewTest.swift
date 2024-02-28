
@testable import PresentationLayer
import PreviewSnapshotsTesting
import XCTest

final class SettingViewTest: XCTestCase {
    func testSettingView() {
        SnapshotConfig.previewTest(SettingView_Previews.self)
    }
}
