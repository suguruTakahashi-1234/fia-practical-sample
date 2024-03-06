
import DomainLayer
import Foundation

/// テスト時に本物の ClipboardDriver を使ってしまうとペースト許諾のアラートが表示されてテストが実行されないため、Mock に差し替えているが、通常は本物を使うため mockable もそのように設定している
/// @mockable(typealias: BuildEnvDriverProtocolAT = BuildEnvDriverProtocolMock; DeviceInfoDriverProtocolAT = DeviceInfoDriver<DeviceNameDriverProtocolMock>; ClipboardDriverProtocolAT = ClipboardDriver;)
public protocol DeviceInfoPresenterDependency {
    associatedtype BuildEnvDriverProtocolAT: BuildEnvDriverProtocol
    associatedtype DeviceInfoDriverProtocolAT: DeviceInfoDriverProtocol
    associatedtype ClipboardDriverProtocolAT: ClipboardDriverProtocol

    var buildEnvDriver: BuildEnvDriverProtocolAT { get }
    var deviceInfoDriver: DeviceInfoDriverProtocolAT { get }
    var clipboardDriver: ClipboardDriverProtocolAT { get }
}
