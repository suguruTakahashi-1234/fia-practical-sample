//
//  Created by sugurutakahashi on 2024/03/01
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum AppRootTab {
    case update
    case setting
}

/// for TabView
extension AppRootTab: Identifiable {
    public var id: String {
        "\(self)"
    }
}

/// for TabView
extension AppRootTab: CaseIterable {}
