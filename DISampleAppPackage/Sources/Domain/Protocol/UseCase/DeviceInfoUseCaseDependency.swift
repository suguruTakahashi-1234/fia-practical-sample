//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable(typealias: BuildEnvDriverProtocolAT = BuildEnvDriverProtocolMock; DeviceInfoDriverProtocolAT = DeviceInfoDriver<DeviceNameDriverProtocolMock>)
public protocol DeviceInfoUseCaseDependency: LocalDataStoreProvider, LogDriverProvider {
    associatedtype BuildEnvDriverProtocolAT: BuildEnvDriverProtocol
    associatedtype DeviceInfoDriverProtocolAT: DeviceInfoDriverProtocol

    var buildEnvDriver: BuildEnvDriverProtocolAT { get }
    var deviceInfoDriver: DeviceInfoDriverProtocolAT { get }
}
