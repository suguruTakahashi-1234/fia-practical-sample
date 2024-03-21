//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public final class LogDriver<Dependency: LogDriverDependency>: LogDriverProtocol {
    private let dependency: Dependency

    public init(dependency: Dependency) {
        OSLogDriver.initLog()

        self.dependency = dependency
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    public func log(_ event: LogEventType, level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        dependency.osLogDriver.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
        dependency.firebaseAnalyticsLogDriver.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
        dependency.firebaseCrashlyticsLogDriver.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
    }
}
