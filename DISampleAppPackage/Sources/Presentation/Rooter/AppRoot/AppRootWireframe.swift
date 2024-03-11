//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer

public protocol AppRootWireframe {
    associatedtype AppRootWireframeAT: AppRootWireframe
    associatedtype SettingPresenterDependencyAT: SettingPresenterDependency
    associatedtype LicenseListPresenterDependencyAT: LicenseListPresenterDependency
    associatedtype LicenseDetailPresenterDependencyAT: LicenseDetailPresenterDependency
    associatedtype DeviceInfoPresenterDependencyAT: DeviceInfoPresenterDependency
    associatedtype TaskListPresenterDependencyAT: TaskListPresenterDependency

    func createHomeTabView() -> HomeTabView<AppRootWireframeAT>
    func createSettingView() -> SettingView<AppRootWireframeAT, SettingPresenterDependencyAT>
    func createLicenseListView() -> LicenseListView<AppRootWireframeAT, LicenseListPresenterDependencyAT>
    func createLicenseDetailView(license: License) -> LicenseDetailView<LicenseDetailPresenterDependencyAT>
    func createDeviceInfoView() -> DeviceInfoView<AppRootWireframeAT, DeviceInfoPresenterDependencyAT>
    func createTaskListView() -> TaskListView<AppRootWireframeAT, TaskListPresenterDependencyAT>
}
