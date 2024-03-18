//
//  Created by sugurutakahashi on 2024/02/16
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer

@MainActor
public protocol AppRootWireframe {
    associatedtype AppRootWireframeAT: AppRootWireframe
    associatedtype OnboardingPresenterDependencyAT: OnboardingPresenterDependency
    associatedtype HomeTabPresenterDependencyAT: HomeTabPresenterDependency
    associatedtype SettingPresenterDependencyAT: SettingPresenterDependency
    associatedtype LicenseListPresenterDependencyAT: LicenseListPresenterDependency
    associatedtype LicenseDetailPresenterDependencyAT: LicenseDetailPresenterDependency
    associatedtype DeviceInfoPresenterDependencyAT: DeviceInfoPresenterDependency
    associatedtype TaskListPresenterDependencyAT: TaskListPresenterDependency

    func createOnboardingView() -> OnboardingView<AppRootWireframeAT, OnboardingPresenterDependencyAT>
    func createHomeTabView() -> HomeTabView<AppRootWireframeAT, HomeTabPresenterDependencyAT>
    func createSettingView() -> SettingView<AppRootWireframeAT, SettingPresenterDependencyAT>
    func createLicenseListView() -> LicenseListView<AppRootWireframeAT, LicenseListPresenterDependencyAT>
    func createLicenseDetailView(license: License) -> LicenseDetailView<LicenseDetailPresenterDependencyAT>
    func createDeviceInfoView() -> DeviceInfoView<AppRootWireframeAT, DeviceInfoPresenterDependencyAT>
    func createTaskListView() -> TaskListView<AppRootWireframeAT, TaskListPresenterDependencyAT>
}
