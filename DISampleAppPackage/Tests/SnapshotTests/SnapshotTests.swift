//
//  Created by sugurutakahashi on 2024/02/21
//  Copyright sugurutakahashi. All rights reserved.
//

import PreviewSnapshotsTesting
import PreviewSnapshots
import XCTest
@testable import PresentationLayer


final class SnapshotTests: XCTestCase {
    func test_AppRootView() {
        AppRootView_Previews.snapshots.assertSnapshots(as: [
            .image(layout: .device(config: .iPhoneSe)),
            .image(layout: .device(config: .iPhone13ProMax)),
        ])
    }
    
    func test_LicenseListView() {
        LicenseListView_Previews.snapshots.assertSnapshots(as: [
            .image(layout: .device(config: .iPhoneSe)),
            .image(layout: .device(config: .iPhone13ProMax)),
        ])
    }
    
    func test_LicenseDetailView() {
        LicenseDetailView_Previews.snapshots.assertSnapshots(as: [
            .image(layout: .device(config: .iPhoneSe)),
            .image(layout: .device(config: .iPhone13ProMax)),
        ])
    }
}
