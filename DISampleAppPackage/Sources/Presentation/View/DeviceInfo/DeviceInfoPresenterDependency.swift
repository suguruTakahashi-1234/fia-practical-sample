
import DomainLayer
import Foundation

/// @mockable(typealias: DeviceInfoDriverProtocolAT = DeviceInfoDriverProtocolMock; BuildEnvRepositoryProtocolAT = BuildEnvRepositoryProtocolMock)
public protocol DeviceInfoPresenterDependency {
    associatedtype DeviceInfoDriverProtocolAT: DeviceInfoDriverProtocol
    associatedtype BuildEnvRepositoryProtocolAT: BuildEnvRepositoryProtocol
    
    var deviceInfoDriver: DeviceInfoDriverProtocolAT { get }
    var buildEnvRepository: BuildEnvRepositoryProtocolAT { get }
}
