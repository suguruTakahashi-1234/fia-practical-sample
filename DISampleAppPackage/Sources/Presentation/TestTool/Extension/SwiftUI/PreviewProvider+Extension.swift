//
//  Created by sugurutakahashi on 2024/02/22
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI
import PreviewSnapshots

public extension PreviewProvider {
    static var emptyConfiguration: [PreviewSnapshots<AppRootRouterDependency>.Configuration] {
        [
            .init(type: .empty, state: NonFrameworkDependencyInjector.empty),
        ]
    }

    static var allSizeConfigurations: [PreviewSnapshots<AppRootRouterDependency>.Configuration] {
        [
            .init(type: .small, state: NonFrameworkDependencyInjector.sizeS),
            .init(type: .medium, state: NonFrameworkDependencyInjector.sizeM),
            .init(type: .large, state: NonFrameworkDependencyInjector.sizeL),
        ]
    }
    
    static var allSizeConfigurationsWithEmpty: [PreviewSnapshots<AppRootRouterDependency>.Configuration] {
        emptyConfiguration + allSizeConfigurations
    }
}
