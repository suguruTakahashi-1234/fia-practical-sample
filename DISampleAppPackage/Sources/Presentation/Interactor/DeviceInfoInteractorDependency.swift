//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

/// @mockable(typealias: DeviceInfoDriverProtocolAT = DeviceInfoDriver<DeviceNameDriverProtocolMock>)
public protocol DeviceInfoInteractorDependency: LogDriverProvider, LocalDataStoreDriverProvider, BuildEnvDriverProvider {
    associatedtype DeviceInfoDriverProtocolAT: DeviceInfoDriverProtocol

    var deviceInfoDriver: DeviceInfoDriverProtocolAT { get }
}
