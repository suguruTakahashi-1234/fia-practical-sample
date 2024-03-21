//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// OSLogDriver については 単独 で使用したいケースがあるため、static メソッドとしている（mockolo の Actor 対応待ち）（本来は Actor Protocol を指定したい）（ただ、現状 Mock を使用するケースがないので困ってはいない）
public protocol OSLogDriverProtocol: LogDriverProtocol {
    static func log(_: LogEventType, level: LogLevel, file: String, function: String, line: Int)
}

public extension OSLogDriverProtocol {
    /// log への簡易アクセス
    static func logging(_ logEventType: LogEventType, level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(logEventType, level: level, file: file.lastPathComponent, function: function, line: line)
    }

    static func debugLog(_ message: String = "", level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        logging(.debug(.init(message: message)), level: level, file: file, function: function, line: line)
    }

    static func initLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        logging(.`init`(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    static func deinitLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        logging(.deinit(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    static func onAppearLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        logging(.appearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }

    static func onDisappearLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        logging(.disappearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }

    static func errorLog(_ appError: AppError?, level: LogLevel = .error, file: String = #filePath, function: String = #function, line: Int = #line) {
        guard let appError else {
            return
        }
        logging(.error(.init(appError: appError, errorName: appError.name)), level: level, file: file, function: function, line: line)
    }

    static func errorLog(_ message: String, level: LogLevel = .error, file: String = #filePath, function: String = #function, line: Int = #line) {
        let appError: AppError = .customError(message)
        logging(.error(.init(appError: appError, errorName: appError.name)), level: level, file: file, function: function, line: line)
    }
}
