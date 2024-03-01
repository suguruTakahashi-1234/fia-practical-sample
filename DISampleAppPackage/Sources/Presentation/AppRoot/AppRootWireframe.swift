//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer

public protocol AppRootWireframe {
    associatedtype AppRootWireframeAT: AppRootWireframe
    associatedtype SettingPresenterDependencyAT: SettingPresenterDependency
    associatedtype LicenseListPresenterDependencyAT: LicenseListPresenterDependency

    func createHomeTabView() -> HomeTabView<AppRootWireframeAT>
    func createSettingView() -> SettingView<AppRootWireframeAT, SettingPresenterDependencyAT>
    func createLicenseListView() -> LicenseListView<AppRootWireframeAT, LicenseListPresenterDependencyAT>
    func createLicenseDetailView(license: License) -> LicenseDetailView
}
