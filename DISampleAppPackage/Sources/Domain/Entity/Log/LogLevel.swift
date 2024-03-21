//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum LogLevel: Sendable {
    case debug
    case info
    case notice // = default
    case error
    case fault
}

public extension LogLevel {
    var name: String {
        "\(self)"
    }

    var description: String {
        switch self {
        case .debug:
            "[debug]  ⬜️"
        case .info:
            "[info]   🔷"
        case .notice:
            "[notice] 🟢"
        case .error:
            "[error]  ⚠️"
        case .fault:
            "[fault]  ❌"
        }
    }
}
