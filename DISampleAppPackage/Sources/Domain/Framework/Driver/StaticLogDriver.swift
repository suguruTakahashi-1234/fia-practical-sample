//
//  Created by sugurutakahashi on 2024/03/11
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// 各Presenterだけではなく、Driver などでも独立して用いたいため、シングルトンのような使い方をしている
/// 現状、この class は使用していないが、今のままだと Driver 中の処理をログ送信する場合は、OSLogDriver のみになり、Firebase や他の Cloud サービスに連携できないため、そのときは any を許容してしまうがこちらの Driver を用いる
/// 現状、Swift の言語仕様上、static な変数と generics は共存できない
public final class StaticLogDriver {
    private nonisolated(unsafe) static var firebaseAnalyticsLogDriver: (any FirebaseAnalyticsLogDriverProtocol)?
    private nonisolated(unsafe) static var firebaseCrashlyticsLogDriver: (any FirebaseCrashlyticsLogDriverProtocol)?

    private init() {}

    public static func setDriver(firebaseAnalyticsLogDriver: any FirebaseAnalyticsLogDriverProtocol, firebaseCrashlyticsLogDriver: any FirebaseCrashlyticsLogDriverProtocol) {
        StaticLogDriver.firebaseAnalyticsLogDriver = firebaseAnalyticsLogDriver
        StaticLogDriver.firebaseCrashlyticsLogDriver = firebaseCrashlyticsLogDriver
    }

    public static func log(_ event: LogEventType, level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
        OSLogDriver.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
        firebaseAnalyticsLogDriver?.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
        firebaseCrashlyticsLogDriver?.log(event, level: level, file: file.lastPathComponent, function: function, line: line)
    }
}

/// よく使う記述は以下の Extension で定義している
public extension StaticLogDriver {
    static func debugLog(_ message: String = "", level: LogLevel = .notice, file: String = #filePath, function: String = #function, line: Int = #line) {
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
