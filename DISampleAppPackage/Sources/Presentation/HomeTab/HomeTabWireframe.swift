
import DomainLayer
import Foundation

public protocol HomeTabWireframe {
    associatedtype SettingWireframeAT: SettingWireframe
    associatedtype SettingPresenterDependencyAT: SettingPresenterDependency
    
    func createSettingView() -> SettingView<SettingWireframeAT, SettingPresenterDependencyAT>
}
