//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// 本来、enum を定義せずに LoggableEntity に準拠した型を引数に取ってもよいが、enum の連想値でどの型の LogEvent を持つか定義することで、ログ出力時の実装効率をよくしている
public enum LogEventType {
    case debug(LogEvent.DebugLog)
    case `init`(LogEvent.InitInstance)
    case `deinit`(LogEvent.DeinitInstance)
    case appearScreen(LogEvent.AppearScreen)
    case disappearScreen(LogEvent.DisappearScreen)
}

public extension LogEventType {
    var logEvent: any LoggableEntity {
        switch self {
        case .debug(let value):
            value
        case .`init`(let value):
            value
        case .deinit(let value):
            value
        case .appearScreen(let value):
            value
        case .disappearScreen(let value):
            value
        }
    }
}

public enum LogEvent {
    public struct DebugLog: LoggableEntity {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }

    public struct InitInstance: LoggableEntity {
        public let instanceName: String

        public init(instanceName: String) {
            self.instanceName = instanceName
        }
    }

    public struct DeinitInstance: LoggableEntity {
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
}
