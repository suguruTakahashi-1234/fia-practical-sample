//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public final class LogDriver<OSLogDriver: OSLogDriverProtocol, FirebaseAnalyticsLogDriver: FirebaseAnalyticsLogDriverProtocol, FirebaseCrashlyticsLogDriver: FirebaseCrashlyticsLogDriverProtocol>: LogDriverProtocol {
    private let osLogDriver: OSLogDriver
    private let firebaseAnalyticsLogDriver: FirebaseAnalyticsLogDriver
    private let firebaseCrashlyticsLogDriver: FirebaseCrashlyticsLogDriver

    /// これ以上、引数が増えるなら LogDriverDependency を適応させた LogDriverDependencyInjector を引数にすることを検討する
    public init(osLogDriver: OSLogDriver, firebaseAnalyticsLogDriver: FirebaseAnalyticsLogDriver, firebaseCrashlyticsLogDriver: FirebaseCrashlyticsLogDriver) {
        OSLogDriver.initLog()

        self.osLogDriver = osLogDriver
        self.firebaseAnalyticsLogDriver = firebaseAnalyticsLogDriver
        self.firebaseCrashlyticsLogDriver = firebaseCrashlyticsLogDriver
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    public func log(_ event: LogEventType, level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        osLogDriver.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
        firebaseAnalyticsLogDriver.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
        firebaseCrashlyticsLogDriver.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
    }
}
