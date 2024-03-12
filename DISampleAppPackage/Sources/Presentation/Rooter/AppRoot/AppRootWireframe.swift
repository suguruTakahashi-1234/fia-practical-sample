//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer

public protocol AppRootWireframe {
    associatedtype AppRootWireframeAT: AppRootWireframe
    associatedtype HomeTabPresenterDependencyAT: HomeTabPresenterDependency
    associatedtype SettingPresenterDependencyAT: SettingPresenterDependency
    associatedtype LicenseListPresenterDependencyAT: LicenseListPresenterDependency
    associatedtype LicenseDetailPresenterDependencyAT: LicenseDetailPresenterDependency
    associatedtype DeviceInfoPresenterDependencyAT: DeviceInfoPresenterDependency
    associatedtype TaskListPresenterDependencyAT: TaskListPresenterDependency

    @MainActor func createHomeTabView() -> HomeTabView<AppRootWireframeAT, HomeTabPresenterDependencyAT>
    @MainActor func createSettingView() -> SettingView<AppRootWireframeAT, SettingPresenterDependencyAT>
    @MainActor func createLicenseListView() -> LicenseListView<AppRootWireframeAT, LicenseListPresenterDependencyAT>
    @MainActor func createLicenseDetailView(license: License) -> LicenseDetailView<LicenseDetailPresenterDependencyAT>
    @MainActor func createDeviceInfoView() -> DeviceInfoView<AppRootWireframeAT, DeviceInfoPresenterDependencyAT>
    @MainActor func createTaskListView() -> TaskListView<AppRootWireframeAT, TaskListPresenterDependencyAT>
}
