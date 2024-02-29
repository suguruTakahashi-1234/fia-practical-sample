//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public actor LoggerContainer {
    private static var loggers: [any LoggerContainable] = []

    public static func append(logger: some LoggerContainable) {
        loggers.append(logger)
    }

    public static func log(_ event: LogEventType, level: LogLevel = .notice, file: String = #file, function: String = #function, line: Int = #line) {
        loggers.forEach { $0.log(event, level: level, file: file.lastPathComponent, function: function, line: line) }
    }
}

/// よく使う記述は以下の Extension で定義している
public extension LoggerContainer {
    static func debugLog(_ message: String = "", level: LogLevel = .notice, file: String = #file, function: String = #function, line: Int = #line) {
        log(.debug(.init(message: message)), level: level, file: file, function: function, line: line)
    }

    static func initLog(level: LogLevel = .notice, file: String = #file, function: String = #function, line: Int = #line) {
        log(.`init`(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    static func deinitLog(level: LogLevel = .notice, file: String = #file, function: String = #function, line: Int = #line) {
        log(.deinit(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    static func logOnAppear(level: LogLevel = .notice, file: String = #file, function: String = #function, line: Int = #line) {
        log(.appearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }

    static func logOnDisappear(level: LogLevel = .notice, file: String = #file, function: String = #function, line: Int = #line) {
        log(.disappearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }
}
