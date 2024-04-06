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

/// for test
extension BuildScheme: RandomValueProvidableForEnum {}
