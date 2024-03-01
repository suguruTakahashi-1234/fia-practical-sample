//
//  Created by sugurutakahashi on 2024/02/21
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum UITestPreviewType {
    case small
    case medium
    case large
    case empty
}

public extension UITestPreviewType {
    var name: String {
        switch self {
        case .small:
            "Size-S"
        case .medium:
            "Size-M"
        case .large:
            "Size-L"
        case .empty:
            "Empty"
        }
    }
}
