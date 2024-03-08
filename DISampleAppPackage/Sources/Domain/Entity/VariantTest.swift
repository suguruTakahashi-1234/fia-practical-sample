//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public struct VariantTest: RemoteConfigurable {
    public let isEnabledNewFeature: Bool

    public init(isEnabledNewFeature: Bool) {
        self.isEnabledNewFeature = isEnabledNewFeature
    }
}

public extension VariantTest {
    static var defaultValue: Self {
        VariantTest(isEnabledNewFeature: false)
    }
}
