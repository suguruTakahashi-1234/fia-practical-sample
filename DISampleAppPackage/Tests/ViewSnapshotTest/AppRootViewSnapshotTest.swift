//
//  Created by sugurutakahashi on 2024/02/29
//  Copyright sugurutakahashi. All rights reserved.
//

@testable import PresentationLayer
import PreviewSnapshotsTesting
import Testing

@Suite struct AppRootViewSnapshotTest {
    @Test @MainActor func previewAppRootView() {
        SnapshotConfig.previewTest(AppRootView_Previews.self)
    }
}
