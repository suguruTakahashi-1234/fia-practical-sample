//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import SwiftUI // for UI

public final class ClipboardDriver: ClipboardDriverProtocol {
    public init() {
        OSLogDriver.initLog()
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    public var copiedValue: String? {
        UIPasteboard.general.string
    }

    public func copy(_ string: String) {
        UIPasteboard.general.string = string
    }
}
