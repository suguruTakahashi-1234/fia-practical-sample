//
//  Created by sugurutakahashi on 2024/03/03
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum BuildScheme: Sendable {
    case mock
    case staging
    case production
}

extension BuildScheme: RandomValueProvidableForEnum {}
