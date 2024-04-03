//
//  Created by sugurutakahashi on 2024/03/03
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum BuildConfiguration: Sendable {
    case debug
    case release
}

public extension BuildConfiguration {
    /// Find Call Hierarchy によって調べるときに便利なため定義している
    var isDebug: Bool {
        self == .debug
    }
}

extension BuildConfiguration: RandomValueProvidableForEnum {}
