//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI // for UI

public class ClipboardDriver: ClipboardDriverProtocol {
    public init() {
        LogDriver.initLog()
    }

    deinit {
        LogDriver.deinitLog()
    }

    public var copiedValue: String? {
        UIPasteboard.general.string
    }

    public func copy(_ string: String) {
        UIPasteboard.general.string = string
    }
}
