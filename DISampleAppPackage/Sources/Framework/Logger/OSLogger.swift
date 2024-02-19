//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer
import os.log

// Ref: https://developer.apple.com/documentation/os/logging/generating_log_messages_from_your_code
// Ref: https://qiita.com/Nick_paper/items/3a6f7d41bc80773b90bf
public class OSLogger: OSLogDriverProtocol {
    private let logger: Logger

    public init(subsystem: String, category: String) {
        logger = Logger(subsystem: subsystem, category: category)
    }

    public func log(_ event: LogEventType, level: LogLevel, file: String, function: String, line: Int) {
        let logDescription = "\(level.description) \(String(describing: event.logEvent)), file: \(file), function: \(function), line: \(line)"

        switch level {
        case .debug:
            logger.debug("\(logDescription)")
        case .info:
            logger.info("\(logDescription)")
        case .notice:
            logger.notice("\(logDescription)")
        case .error:
            logger.error("\(logDescription)")
        case .fault:
            logger.fault("\(logDescription)")
        }
    }
}
