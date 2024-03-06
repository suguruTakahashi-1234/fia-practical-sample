
import DomainLayer
import Foundation

/// テスト時に本物の ClipboardDriver を使ってしまうとペースト許諾のアラートが表示されてテストが実行されないため、Mock に差し替えているが、通常は本物を使うため mockable もそのように設定している
/// @mockable(typealias: BuildEnvRepositoryProtocolAT = BuildEnvRepositoryProtocolMock; DeviceInfoDriverProtocolAT = DeviceInfoDriverProtocolMock; ClipboardDriverProtocolAT = ClipboardDriver;)
public protocol DeviceInfoPresenterDependency {
    associatedtype BuildEnvRepositoryProtocolAT: BuildEnvRepositoryProtocol
    associatedtype DeviceInfoDriverProtocolAT: DeviceInfoDriverProtocol
    associatedtype ClipboardDriverProtocolAT: ClipboardDriverProtocol

    var buildEnvRepository: BuildEnvRepositoryProtocolAT { get }
    var deviceInfoDriver: DeviceInfoDriverProtocolAT { get }
    var clipboardDriver: ClipboardDriverProtocolAT { get }
}
