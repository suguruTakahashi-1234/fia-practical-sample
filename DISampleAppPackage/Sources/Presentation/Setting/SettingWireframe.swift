
import DomainLayer
import Foundation

public protocol SettingWireframe {
    associatedtype Wireframe: LicenseListWireframe
    associatedtype PresenterDependency: LicenseListPresenterDependency

    func createLicenseListView() -> LicenseListView<Wireframe, PresenterDependency>
}
