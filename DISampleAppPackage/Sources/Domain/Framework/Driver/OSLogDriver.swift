//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import os.log

// Ref: https://developer.apple.com/documentation/os/logging/generating_log_messages_from_your_code
// Ref: https://qiita.com/Nick_paper/items/3a6f7d41bc80773b90bf
public final class OSLogDriver: OSLogDriverProtocol {
    /// 現状、thread safe でなくても問題ない
    private nonisolated(unsafe) static let _logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: Constants.LogCategory.staticOSLogger)
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: Constants.LogCategory.osLogger)

    public init() {
        OSLogDriver.initLog()
    }

    deinit {
        OSLogDriver.deinitLog()
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

    public static func log(_ event: LogEventType, level: LogLevel, file: String, function: String, line: Int) {
        let logDescription = "\(level.description) \(String(describing: event.logEvent)), file: \(file), function: \(function), line: \(line)"

        switch level {
        case .debug:
            OSLogDriver._logger.debug("\(logDescription)")
        case .info:
            OSLogDriver._logger.info("\(logDescription)")
        case .notice:
            OSLogDriver._logger.notice("\(logDescription)")
        case .error:
            OSLogDriver._logger.error("\(logDescription)")
        case .fault:
            OSLogDriver._logger.fault("\(logDescription)")
        }
    }
}
