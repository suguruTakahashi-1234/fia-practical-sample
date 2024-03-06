//
//  Created by sugurutakahashi on 2024/03/06
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

/// @mockable(typealias: BuildEnvRepositoryProtocolAT = BuildEnvRepositoryProtocolMock; DeviceInfoDriverProtocolAT = DeviceInfoDriverProtocolMock; DeviceInfoUseCaseAT = DeviceInfoInteractor<BuildEnvRepositoryProtocolMock, DeviceInfoDriverProtocolMock>)
public protocol DeviceInfoInteractorDependency {
    associatedtype BuildEnvRepositoryProtocolAT: BuildEnvRepositoryProtocol
    associatedtype DeviceInfoDriverProtocolAT: DeviceInfoDriverProtocol
    associatedtype DeviceInfoUseCaseAT: DeviceInfoUseCase
    
    var buildEnvRepository: BuildEnvRepositoryProtocolAT { get }
    var deviceInfoDriver: DeviceInfoDriverProtocolAT { get }
    var deviceInfoUseCase: DeviceInfoUseCaseAT { get }
}
