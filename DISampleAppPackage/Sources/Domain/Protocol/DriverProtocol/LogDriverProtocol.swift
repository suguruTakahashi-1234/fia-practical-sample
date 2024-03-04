//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol LogDriverProtocol {
    func log(_: LogEventType, level: LogLevel, file: String, function: String, line: Int)
}
