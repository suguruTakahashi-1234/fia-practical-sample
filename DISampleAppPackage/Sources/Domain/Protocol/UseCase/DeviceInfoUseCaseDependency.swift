//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable(typealias: DeviceInfoDriverProtocolAT = DeviceInfoDriver<DeviceNameDriverProtocolMock>)
public protocol DeviceInfoUseCaseDependency: LocalDataStoreProvider, LogDriverProvider, BuildEnvDriverProvider {
    associatedtype DeviceInfoDriverProtocolAT: DeviceInfoDriverProtocol

    var deviceInfoDriver: DeviceInfoDriverProtocolAT { get }
}
