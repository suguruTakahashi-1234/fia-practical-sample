//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import DeviceKit
import DomainLayer

public final class DeviceNameDriver: DeviceNameDriverProtocol {
    public init() {
        OSLogDriver.initLog()
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    public var deviceName: String {
        DeviceKit.Device.current.safeDescription
    }
}
