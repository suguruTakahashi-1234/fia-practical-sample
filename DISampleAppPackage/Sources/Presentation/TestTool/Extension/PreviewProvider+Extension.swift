//
//  Created by sugurutakahashi on 2024/02/22
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import PreviewSnapshots

public extension PreviewProvider {
    static var configurationEmpty: [PreviewSnapshots<AppRootRouterDependencyMock>.Configuration] {
        [
            .init(type: .empty, state: .empty),
        ]
    }
    
    static var configurationAllSizes: [PreviewSnapshots<AppRootRouterDependencyMock>.Configuration] {
        [
            .init(type: .small, state: .sizeS),
            .init(type: .medium, state: .sizeM),
            .init(type: .large, state: .sizeL),
        ]
    }
    
    static var configurationAllSizesWithEmpty: [PreviewSnapshots<AppRootRouterDependencyMock>.Configuration] {
        configurationEmpty + configurationAllSizes
    }
}
