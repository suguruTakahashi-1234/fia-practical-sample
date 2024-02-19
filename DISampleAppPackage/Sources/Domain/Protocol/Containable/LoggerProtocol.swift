//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol LoggerContainable: AnyObject {
    func log(_: LogEventType, level: LogLevel, file: String, function: String, line: Int)
}
