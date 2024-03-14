//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable(typealias: LocalDataStoreProtocolAT = LocalDataStore; BuildEnvDriverProtocolAT = BuildEnvDriverProtocolMock; DeviceInfoDriverProtocolAT = DeviceInfoDriver<DeviceNameDriverProtocolMock>)
public protocol DeviceInfoUseCaseDependency: LogDriverProvider {
    associatedtype LocalDataStoreProtocolAT: LocalDataStoreProtocol
    associatedtype BuildEnvDriverProtocolAT: BuildEnvDriverProtocol
    associatedtype DeviceInfoDriverProtocolAT: DeviceInfoDriverProtocol

    var localDataStore: LocalDataStoreProtocolAT { get }
    var buildEnvDriver: BuildEnvDriverProtocolAT { get }
    var deviceInfoDriver: DeviceInfoDriverProtocolAT { get }
}
