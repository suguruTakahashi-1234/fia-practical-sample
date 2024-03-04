//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

/// TODO: DeviceInfoDriverProtocol に新しい変数が追加されるときに更新する仕組みがほしい（なくてもそこまで問題ではないが）
public extension DeviceInfoDriverProtocolMock {
    convenience init(deviceInfoDriver: DeviceInfoDriver<DeviceNameDriverProtocolMock>) {
        self.init(
            appVersion: deviceInfoDriver.appVersion,
            appBuildNumber: deviceInfoDriver.appBuildNumber,
            deviceName: deviceInfoDriver.deviceName,
            deviceIdentifier: deviceInfoDriver.deviceIdentifier,
            isSimulator: deviceInfoDriver.isSimulator,
            isPreview: deviceInfoDriver.isPreview,
            osType: deviceInfoDriver.osType,
            osVersion: deviceInfoDriver.osVersion,
            timezone: deviceInfoDriver.timezone,
            language: deviceInfoDriver.language
        )
    }
}
