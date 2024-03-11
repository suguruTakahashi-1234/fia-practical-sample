//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// 各Presenterだけではなく、Driver などでも独立して用いたいため、シングルトンのような使い方をしている
public actor LogDriver {
    private init() {}

    private static let osLogDriver: some OSLogDriverProtocol = OSLogDriver(subsystem: Bundle.main.bundleIdentifier!, category: Constants.Logger.categoryName)
    /// ジェネリクスとシングルトンは両立できないため（static な変数とジェネリクスは Swift の言語仕様で共存できない）、例外的に any を許容している
    private static var firebaseLogDriver: (any FirebaseLogDriverProtocol)?

    public static func setDriver(firebaseLogDriver: any FirebaseLogDriverProtocol) {
        Self.firebaseLogDriver = firebaseLogDriver
    }

    public static func log(_ event: LogEventType, level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        osLogDriver.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
        firebaseLogDriver?.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
    }
}

/// よく使う記述は以下の Extension で定義している
public extension LogDriver {
    static func debugLog(_ message: String = "", level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.debug(.init(message: message)), level: level, file: file, function: function, line: line)
    }

    static func initLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.`init`(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    static func deinitLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.deinit(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    static func onAppearLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.appearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }

    static func onDisappearLog(level: LogLevel = .info, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.disappearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }

    static func errorLog(_ appError: AppError?, level: LogLevel = .error, file: String = #filePath, function: String = #function, line: Int = #line) {
        guard let appError else {
            return
        }
        log(.error(.init(appError: appError, errorName: appError.name)), level: level, file: file, function: function, line: line)
    }

    static func errorLog(_ message: String, level: LogLevel = .error, file: String = #filePath, function: String = #function, line: Int = #line) {
        let appError: AppError = .customError(message)
        log(.error(.init(appError: appError, errorName: appError.name)), level: level, file: file, function: function, line: line)
    }
}
