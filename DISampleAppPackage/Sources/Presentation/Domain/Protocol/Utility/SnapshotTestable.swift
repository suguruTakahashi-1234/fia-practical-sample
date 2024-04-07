//
//  Created by sugurutakahashi on 2024/02/24
//  Copyright sugurutakahashi. All rights reserved.
//

import PreviewSnapshots
import SwiftUI

public protocol SnapshotTestable {
    associatedtype State

    @MainActor
    static var snapshots: PreviewSnapshots<State> { get }
}

public extension SnapshotTestable {
    @MainActor
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
}
