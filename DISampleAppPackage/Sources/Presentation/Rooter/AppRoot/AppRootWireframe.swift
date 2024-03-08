//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer

public protocol AppRootWireframe {
    associatedtype AppRootWireframeAT: AppRootWireframe
    associatedtype SettingPresenterDependencyAT: SettingPresenterDependency
    associatedtype LicenseListPresenterDependencyAT: LicenseListPresenterDependency
    associatedtype DeviceInfoPresenterDependencyAT: DeviceInfoPresenterDependency
    associatedtype TaskListPresenterDependencyAT: TaskListPresenterDependency

    func createHomeTabView() -> HomeTabView<AppRootWireframeAT>
    func createSettingView() -> SettingView<AppRootWireframeAT, SettingPresenterDependencyAT>
    func createLicenseListView() -> LicenseListView<AppRootWireframeAT, LicenseListPresenterDependencyAT>
    func createLicenseDetailView(license: License) -> LicenseDetailView
    func createDeviceInfoView() -> DeviceInfoView<AppRootWireframeAT, DeviceInfoPresenterDependencyAT>
    func createTaskListView() -> TaskListView<AppRootWireframeAT, TaskListPresenterDependencyAT>
}
