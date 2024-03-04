
import DomainLayer
import Foundation

/// テスト時に本物の ClipboardDriver を使ってしまうとペースト許諾のアラートが表示されてテストが実行されないため、Mock に差し替えているが、通常は本物を使うため mockable もそのように設定している
/// @mockable(typealias: DeviceInfoDriverProtocolAT = DeviceInfoDriverProtocolMock; BuildEnvRepositoryProtocolAT = BuildEnvRepositoryProtocolMock; ClipboardDriverProtocolAT = ClipboardDriver)
public protocol DeviceInfoPresenterDependency {
    associatedtype DeviceInfoDriverProtocolAT: DeviceInfoDriverProtocol
    associatedtype BuildEnvRepositoryProtocolAT: BuildEnvRepositoryProtocol
    associatedtype ClipboardDriverProtocolAT: ClipboardDriverProtocol
    
    var deviceInfoDriver: DeviceInfoDriverProtocolAT { get }
    var buildEnvRepository: BuildEnvRepositoryProtocolAT { get }
    var clipboardDriver: ClipboardDriverProtocolAT { get }
}
