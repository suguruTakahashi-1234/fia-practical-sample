//
//  Created by sugurutakahashi on 2024/02/24
//  Copyright sugurutakahashi. All rights reserved.
//

import PreviewSnapshots

public protocol SnapshotTestable {
    associatedtype State

    static var snapshots: PreviewSnapshots<State> { get }
}


