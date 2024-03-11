//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public class LogDriver<OSLogDriver: OSLogDriverProtocol, FirebaseLogDriver: FirebaseLogDriverProtocol>: LogDriverProtocol {
    private let osLogDriver: OSLogDriver
    private let firebaseLogDriver: FirebaseLogDriver

    public init(osLogDriver: OSLogDriver, firebaseLogDriver: FirebaseLogDriver) {
        OSLogDriver.deinitLog()

        self.osLogDriver = osLogDriver
        self.firebaseLogDriver = firebaseLogDriver
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    public func log(_ event: LogEventType, level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        osLogDriver.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
        firebaseLogDriver.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
    }
}
