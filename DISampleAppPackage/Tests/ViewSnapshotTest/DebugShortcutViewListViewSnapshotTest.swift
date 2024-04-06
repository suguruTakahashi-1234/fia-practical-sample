//
//  Created by sugurutakahashi on 2024/04/06
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct DebugShortcutViewListViewSnapshotTest {
    @Test @MainActor func previewTest() {
        SnapshotConfig.previewTest(DebugShortcutViewListView_Previews.self)
    }
}
