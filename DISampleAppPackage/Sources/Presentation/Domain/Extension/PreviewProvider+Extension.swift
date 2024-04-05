//
//  Created by sugurutakahashi on 2024/02/22
//  Copyright sugurutakahashi. All rights reserved.
//

import PreviewSnapshots
import SwiftUI

public extension UITestPreviewType {
    var configuration: PreviewSnapshots<AppRootRouterDependencyMock>.Configuration {
        .init(name: name, state: mock)
    }
}

public extension PreviewProvider {
    static var allSizes: [PreviewSnapshots<AppRootRouterDependencyMock>.Configuration] {
        [
            UITestPreviewType.small.configuration,
            UITestPreviewType.medium.configuration,
            UITestPreviewType.large.configuration,
        ]
    }
}
