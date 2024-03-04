//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import FirebaseAnalytics

public struct FirebaseLogDriver: FirebaseLogDriverProtocol {
    public init() {}

    public func log(_ event: LogEventType, level: LogLevel, file: String, function: String, line: Int) {
        // TODO: event を辞書型に変換する
        // Analytics.logEvent("\(String(describing: event.logEvent)), logLevel: \(level.name), file: \(file), function: \(function), line: \(line)", parameters: [:])
        Analytics.logEvent("\(file.fileNameWithoutExtension)", parameters: [:]) // TDOD: 消す
    }
}
