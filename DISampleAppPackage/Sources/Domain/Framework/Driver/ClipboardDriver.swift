//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

#if os(iOS)
    import SwiftUI // for UIPasteboard
#elseif os(macOS)
    import AppKit // NSPasteboard
#endif

public final class ClipboardDriver: ClipboardDriverProtocol {
    public init() {
        OSLogDriver.initLog()
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    public var copiedValue: String? {
        #if os(iOS)
            UIPasteboard.general.string
        #else
            OSLogDriver.errorLog("Unsupported by iOS Only")
            return nil
        #endif
    }

    public func copy(_ text: String) {
        #if os(iOS)
            UIPasteboard.general.string = text
        #else
            OSLogDriver.errorLog("Unsupported by iOS Only")
        #endif
    }
}
