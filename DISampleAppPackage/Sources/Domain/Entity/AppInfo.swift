//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public struct AppInfo: RemoteConfigurable {
    public let appUpdateInfo: AppUpdateInfo
    public let maintenanceInfo: MaintenanceInfo

    public init(appUpdateInfo: AppUpdateInfo, maintenanceInfo: MaintenanceInfo) {
        self.appUpdateInfo = appUpdateInfo
        self.maintenanceInfo = maintenanceInfo
    }
}

public extension AppInfo {
    static var defaultValue: Self {
        AppInfo(
            appUpdateInfo: AppUpdateInfo(minimumRequiredAppVersion: "0.0.0", appUpdateUrl: ""),
            maintenanceInfo: MaintenanceInfo(isMaintenance: false, maintenanceAlertTitle: "", maintenanceAlertMessage: "")
        )
    }
}
