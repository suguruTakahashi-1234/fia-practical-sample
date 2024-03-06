//
//  Created by sugurutakahashi on 2024/03/06
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

/// @mockable(typealias: BuildEnvRepositoryProtocolAT = BuildEnvRepositoryProtocolMock; DeviceInfoDriverProtocolAT = DeviceInfoDriverProtocolMock; DeviceInfoUsecaseAT = DeviceInfoInteractor<BuildEnvRepositoryProtocolMock, DeviceInfoDriverProtocolMock>)
public protocol DeviceInfoInteractorDependency {
    associatedtype BuildEnvRepositoryProtocolAT: BuildEnvRepositoryProtocol
    associatedtype DeviceInfoDriverProtocolAT: DeviceInfoDriverProtocol
    associatedtype DeviceInfoUsecaseAT: DeviceInfoUsecase
    
    var buildEnvRepository: BuildEnvRepositoryProtocolAT { get }
    var deviceInfoDriver: DeviceInfoDriverProtocolAT { get }
    var deviceInfoUsecase: DeviceInfoUsecaseAT { get }
}
