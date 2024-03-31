//
//  Created by sugurutakahashi on 2024/03/03
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum BuildScheme: Sendable {
    case testing
    case development
    case staging
    case production
}

public extension BuildScheme {
    /// Find Call Hierarchy によって .testing の分岐を調べるときに便利なため定義している
    var isTesting: Bool {
        self == .testing
    }
}

/// for test
extension BuildScheme: RandomValueProvidableForEnum {}
