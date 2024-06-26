
import DomainLayer
import Foundation

/// テスト時に本物の ClipboardDriver を使ってしまうとペースト許諾のアラートが表示されてテストが実行されないため、Mock に差し替えているが、通常は本物を使うため mockable もそのように設定している
/// @mockable(typealias: ClipboardDriverProtocolAT = ClipboardDriver)
public protocol DeviceInfoPresenterDependency: CommonPresenterDependency, DeviceInfoInteractorDependency {
    associatedtype ClipboardDriverProtocolAT: ClipboardDriverProtocol

    var clipboardDriver: ClipboardDriverProtocolAT { get }
}
