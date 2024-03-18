//
//  Created by sugurutakahashi on 2024/03/01
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum HomeTab: Sendable {
    case task
    case setting
}

/// for TabView
extension HomeTab: Identifiable, CaseIterable {
    public var id: String {
        "\(self)"
    }
}
