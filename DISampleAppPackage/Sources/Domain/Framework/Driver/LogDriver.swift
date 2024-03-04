//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

//public actor LoggerContainer {
//    private static var loggers: [any LoggerContainable] = []
//    private static var osLogDriver: any OSLogDriverProtocol?
//
//    public static func append(logger: some LoggerContainable) {
//        loggers.append(logger)
//    }
//
//    public static func append(osLogDriver: any OSLogDriverProtocol) {
//        self.osLogDriver = osLogDriver
//    }
//    
//    public static func log(_ event: LogEventType, level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
//        osLogDriver?.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
//    }
//}

/// 各Presenterだけではなく、Driver などでも独立して用いたいため、シングルトンのような使い方をしている
public actor LogDriver {
    private static var osLogDriver: some OSLogDriverProtocol = OSLogDriver(subsystem: Bundle.main.bundleIdentifier!, category: Constants.Logger.categoryName)
    // ジェネリクスとシングルトンは両立できないため、例外的に any を許容している
    private static var firebaseLogDriver: (any FirebaseLogDriverProtocol)?
    
    public static func setDriver(firebaseLogDriver: any FirebaseLogDriverProtocol) {
        LogDriver.firebaseLogDriver = firebaseLogDriver
    }

    public static func log(_ event: LogEventType, level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        osLogDriver.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
        firebaseLogDriver?.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
    }
}

/// よく使う記述は以下の Extension で定義している
public extension LogDriver {
    static func debugLog(_ message: String = "", level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.debug(.init(message: message)), level: level, file: file, function: function, line: line)
    }

    static func initLog(level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.`init`(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    static func deinitLog(level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.deinit(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    static func logOnAppear(level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.appearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }

    static func logOnDisappear(level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.disappearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }
}


public actor LoggerContainer {
    private static var osLogDriver: (any OSLogDriverProtocol)?
    
    public static func append(osLogDriver: any OSLogDriverProtocol) {
        self.osLogDriver = osLogDriver
    }
    
    public static func log(_ event: LogEventType, level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        osLogDriver?.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
    }
}

/// よく使う記述は以下の Extension で定義している
public extension LoggerContainer {
    static func debugLog(_ message: String = "", level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.debug(.init(message: message)), level: level, file: file, function: function, line: line)
    }

    static func initLog(level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.`init`(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    static func deinitLog(level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.deinit(.init(instanceName: file.fileNameWithoutExtension)), level: level, file: file, function: function, line: line)
    }

    static func logOnAppear(level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.appearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }

    static func logOnDisappear(level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        log(.disappearScreen(.init(screenName: file.lastPathComponent.replacingOccurrences(of: "Presenter.swift", with: "").toSnakeCase)), level: level, file: file, function: function, line: line)
    }
}
