//
//  Created by sugurutakahashi on 2024/04/07
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct SFSymbolsListViewSnapshotTest {
    @Test @MainActor func previewTest() {
        SnapshotConfig.previewTest(SFSymbolsListView_Previews.self)
    }
}
