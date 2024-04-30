//
//  Created by sugurutakahashi on 2024/04/30
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol AppRootDIContainerDependency: AnyObject, AppRootPresenterDependency, CommonPresenterDependency, DebugMenuPresenterDependency, DebugShortcutViewListPresenterDependency, DebugViewCatalogListPresenterDependency, DeviceInfoPresenterDependency, HomeTabPresenterDependency, LicenseDetailPresenterDependency, LicenseListPresenterDependency, OnboardingPresenterDependency, SettingPresenterDependency, TaskListPresenterDependency {}
