//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// 本来、enum を定義せずに LoggableEntity に準拠した型を log 出力時に引数に取ってもよいが、enum の連想値でどの型の LogEvent を持つか定義することで、ログ出力時の実装の効率をよくしている（本質的な意味はほぼない CaseIterable などを使うケースがあれば別だが）
public enum LogEventType: Sendable {
    case debug(LogEvent.Debug)
    case error(LogEvent.Error)
    case `init`(LogEvent.Init)
    case `deinit`(LogEvent.Deinit)
    case appearScreen(LogEvent.AppearScreen)
    case disappearScreen(LogEvent.DisappearScreen)
    case updateLocalDataStore(LogEvent.UpdateLocalDataStore)
    case launchApp(LogEvent.LaunchApp)
}

public extension LogEventType {
    var logEvent: any LoggableEntity {
        switch self {
        case .debug(let value):
            value
        case .error(let value):
            value
        case .`init`(let value):
            value
        case .deinit(let value):
            value
        case .appearScreen(let value):
            value
        case .disappearScreen(let value):
            value
        case .updateLocalDataStore(let value):
            value
        case .launchApp(let value):
            value
        }
    }
}

public enum LogEvent: Sendable {
    public struct Debug: LoggableEntity {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }

    public struct Error: LoggableEntity {
        public let appError: AppError
        public let errorName: String

        public init(appError: AppError, errorName: String) {
            self.appError = appError
            self.errorName = errorName
        }
    }

    public struct Init: LoggableEntity {
        public let instanceName: String

        public init(instanceName: String) {
            self.instanceName = instanceName
        }
    }

    public struct Deinit: LoggableEntity {
        public let instanceName: String

        public init(instanceName: String) {
            self.instanceName = instanceName
        }
    }

    public struct AppearScreen: LoggableEntity {
        public let screenName: String

        public init(screenName: String) {
            self.screenName = screenName
        }
    }

    public struct DisappearScreen: LoggableEntity {
        public let screenName: String

        public init(screenName: String) {
            self.screenName = screenName
        }
    }

    public struct UpdateLocalDataStore: LoggableEntity {
        public let key: String
        public let oldValue: String
        public let newValue: String

        public init(key: String, oldValue: String, newValue: String) {
            self.key = key
            self.oldValue = oldValue
            self.newValue = newValue
        }
    }

    public struct LaunchApp: LoggableEntity {
        public let count: Int

        public init(count: Int) {
            self.count = count
        }
    }
}
