//
//  Created by sugurutakahashi on 2024/04/04
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol AppRootRouterDependency: AnyObject, AppRootPresenterDependency, CommonPresenterDependency, DebugMenuPresenterDependency, DeviceInfoPresenterDependency, HomeTabPresenterDependency, LicenseDetailPresenterDependency, LicenseListPresenterDependency, OnboardingPresenterDependency, SettingPresenterDependency, TaskListPresenterDependency {}
