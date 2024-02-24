//
//  Created by sugurutakahashi on 2024/02/24
//  Copyright sugurutakahashi. All rights reserved.
//

import PreviewSnapshots
@testable import PresentationLayer

protocol SnapshotTestable {
    associatedtype State
    static var snapshots: PreviewSnapshots<State> { get }
}

extension AppRootView_Previews: SnapshotTestable {}
extension LicenseListView_Previews: SnapshotTestable {}
extension LicenseDetailView_Previews: SnapshotTestable {}
