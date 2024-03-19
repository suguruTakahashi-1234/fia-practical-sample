//
//  Created by sugurutakahashi on 2024/02/21
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum UITestPreviewType {
    case empty
    case standard
    case small
    case medium
    case large
}

public extension UITestPreviewType {
    var name: String {
        switch self {
        case .empty:
            "Empty"
        case .standard:
            "Standard"
        case .small:
            "Size-S"
        case .medium:
            "Size-M"
        case .large:
            "Size-L"
        }
    }
}
