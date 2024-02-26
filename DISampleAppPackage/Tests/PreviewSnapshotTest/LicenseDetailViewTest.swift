//
//  Created by sugurutakahashi on 2024/02/26
//  Copyright sugurutakahashi. All rights reserved.
//

import PreviewSnapshotsTesting
import XCTest
@testable import PresentationLayer

final class LicenseDetailViewTest: XCTestCase {
    func testLicenseDetailView() {
        SnapshotConfig.previewTest(LicenseDetailView_Previews.self)
    }
}
