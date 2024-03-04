//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import DeviceKit
import DomainLayer

public struct DeviceNameDriver: DeviceNameDriverProtocol {
    public init() {
        LogDriver.initLog()
    }

    public var deviceName: String {
        DeviceKit.Device.current.safeDescription
    }
}
