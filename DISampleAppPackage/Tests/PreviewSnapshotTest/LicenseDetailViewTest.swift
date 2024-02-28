//
//  Created by sugurutakahashi on 2024/02/26
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import XCTest

final class LicenseDetailViewTest: XCTestCase {
    func testLicenseDetailView() {
        SnapshotConfig.previewTest(LicenseDetailView_Previews.self)
    }
}
