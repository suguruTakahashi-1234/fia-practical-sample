//
//  Created by sugurutakahashi on 2024/02/21
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum UITestScenarioType {
    case small
    case medium
    case large
    case empty
}

public extension UITestScenarioType {
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

