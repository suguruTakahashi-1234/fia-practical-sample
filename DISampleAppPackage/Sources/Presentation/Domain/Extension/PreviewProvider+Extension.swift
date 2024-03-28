//
//  Created by sugurutakahashi on 2024/02/22
//  Copyright sugurutakahashi. All rights reserved.
//

import PreviewSnapshots
import SwiftUI

private extension UITestPreviewType {
    var mock: AppRootRouterDependencyMock {
        switch self {
        case .empty:
            .empty
        case .standard:
            .randomForSnapshotTest
        case .small:
            .sizeS
        case .medium:
            .sizeM
        case .large:
            .sizeL
        }
    }

    var configuration: PreviewSnapshots<AppRootRouterDependencyMock>.Configuration {
        .init(name: name, state: mock)
    }
}

public extension PreviewProvider {
    static var empty: [PreviewSnapshots<AppRootRouterDependencyMock>.Configuration] {
        [
            UITestPreviewType.empty.configuration,
        ]
    }

    static var standard: [PreviewSnapshots<AppRootRouterDependencyMock>.Configuration] {
        [
            UITestPreviewType.standard.configuration,
        ]
    }

    static var allSizes: [PreviewSnapshots<AppRootRouterDependencyMock>.Configuration] {
        [
            UITestPreviewType.small.configuration,
            UITestPreviewType.medium.configuration,
            UITestPreviewType.large.configuration,
        ]
    }

    static var allSizesWithEmpty: [PreviewSnapshots<AppRootRouterDependencyMock>.Configuration] {
        allSizes + empty
    }
}
