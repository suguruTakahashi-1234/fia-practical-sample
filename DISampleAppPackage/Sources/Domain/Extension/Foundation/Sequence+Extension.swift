//
//  Created by sugurutakahashi on 2024/03/18
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public extension Sequence {
    func sorted(by keyPath: KeyPath<Element, some Comparable>, order: SortOrder) -> [Element] {
        switch order {
        case .ascending:
            sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
        case .descending:
            sorted { $0[keyPath: keyPath] > $1[keyPath: keyPath] }
        }
    }
}
