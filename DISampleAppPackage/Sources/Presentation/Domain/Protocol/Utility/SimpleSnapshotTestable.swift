//
//  Created by sugurutakahashi on 2024/04/07
//  Copyright sugurutakahashi. All rights reserved.
//

import PreviewSnapshots
import SwiftUI

public protocol SimpleSnapshotTestable: SnapshotTestable {
    associatedtype T: View

    @MainActor
    static var snapshot: T { get }
}

public extension SimpleSnapshotTestable {
    @MainActor
    static var snapshots: PreviewSnapshots<Void> {
        .init(
            configurations: [.init(name: "\(self)".sliceToViewName, state: ())],
            configure: { _ in
                snapshot
            }
        )
    }
}
