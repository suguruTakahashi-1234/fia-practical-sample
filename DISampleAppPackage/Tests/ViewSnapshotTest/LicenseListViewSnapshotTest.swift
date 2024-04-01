//
//  Created by sugurutakahashi on 2024/02/26
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct LicenseListViewSnapshotTest {
    @Test @MainActor func previewTest() {
        SnapshotConfig.previewTest(LicenseListView_Previews.self)
    }
}
