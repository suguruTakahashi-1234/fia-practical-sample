//
//  Created by sugurutakahashi on 2024/04/30
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct DebugViewCatalogListViewSnapshotTest {
    @Test @MainActor func previewTest() {
        SnapshotConfig.previewTest(DebugViewCatalogListView_Previews.self)
    }
}
