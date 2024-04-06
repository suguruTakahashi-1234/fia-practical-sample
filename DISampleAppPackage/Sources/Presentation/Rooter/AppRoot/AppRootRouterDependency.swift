//
//  Created by sugurutakahashi on 2024/04/06
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol AppRootRouterDependency: AnyObject, AppRootPresenterDependency, CommonPresenterDependency, DebugMenuPresenterDependency, DebugShortcutViewListPresenterDependency, DeviceInfoPresenterDependency, HomeTabPresenterDependency, LicenseDetailPresenterDependency, LicenseListPresenterDependency, OnboardingPresenterDependency, SettingPresenterDependency, TaskListPresenterDependency {}
