//
//  Created by sugurutakahashi on 2024/02/21
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum UITestPreviewType {
    case empty
    case standard
    case placeholder
    case small
    case medium
    case large
    case releaseBuildConfiguration
}

public extension UITestPreviewType {
    var name: String {
        switch self {
        case .empty:
            "Empty"
        case .standard:
            "Standard"
        case .placeholder:
            "Placeholder"
        case .small:
            "Size-S"
        case .medium:
            "Size-M"
        case .large:
            "Size-L"
        case .releaseBuildConfiguration:
            "Release-Build-Configuration"
        }
    }

    var mock: AppRootDIContainerDependencyMock {
        switch self {
        case .empty:
            .empty
        case .standard:
            .randomForSnapshotTest
        case .placeholder:
            .placeholder
        case .small:
            .sizeS
        case .medium:
            .sizeM
        case .large:
            .sizeL
        case .releaseBuildConfiguration:
            .releaseBuildConfiguration
        }
    }
}
