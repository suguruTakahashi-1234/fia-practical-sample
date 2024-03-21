//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol LogDriverProtocol: AnyObject {
    func log(_: LogEventType, level: LogLevel, file: String, function: String, line: Int)
}

public extension LogDriverProtocol {
    /// log()  への簡易アクセス
    func logging(_ logEventType: LogEventType, level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(logEventType, level: level, file: file.lastPathComponent, function: function, line: line)
    }

    func debugLog(_ message: String = "", level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        logging(.debug(.init(message: message)), level: level, file: file, function: function, line: line)
    }

    func initLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        logging(.`init`(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    func deinitLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        logging(.deinit(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    func onAppearLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        logging(.appearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }

    func onDisappearLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        logging(.disappearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }

    func errorLog(_ appError: AppError?, level: LogLevel = .error, file: String = #filePath, function: String = #function, line: Int = #line) {
        guard let appError else {
            return
        }
        logging(.error(.init(appError: appError, errorName: appError.name)), level: level, file: file, function: function, line: line)
    }

    func errorLog(_ message: String, level: LogLevel = .error, file: String = #filePath, function: String = #function, line: Int = #line) {
        let appError: AppError = .customError(message)
        logging(.error(.init(appError: appError, errorName: appError.name)), level: level, file: file, function: function, line: line)
    }
}
