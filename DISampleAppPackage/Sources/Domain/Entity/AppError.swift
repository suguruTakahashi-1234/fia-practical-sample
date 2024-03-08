//
//  Created by sugurutakahashi on 2024/03/08
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum AppError: Error {
    case customError(String)
}

public extension AppError {
    var name: String {
        "\(self)"
    }
}

public extension Error {
    var toAppError: AppError {
        switch self {
        case let appError as AppError:
            appError
        default:
            .customError(String(describing: self))
        }
    }
}
