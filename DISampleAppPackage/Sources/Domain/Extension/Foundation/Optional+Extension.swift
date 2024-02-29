//
//  Created by sugurutakahashi on 2024/02/29
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public extension Optional {
    var isNil: Bool {
        self == nil
    }

    var isNotNil: Bool {
        self != nil
    }
}
