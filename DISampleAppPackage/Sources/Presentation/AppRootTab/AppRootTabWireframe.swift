
import DomainLayer
import Foundation

public protocol AppRootTabWireframe {
    associatedtype SettingWireframeAT: SettingWireframe
    associatedtype SettingPresenterDependencyAT: SettingPresenterDependency
    
    func createSettingView() -> SettingView<SettingWireframeAT, SettingPresenterDependencyAT>
}
