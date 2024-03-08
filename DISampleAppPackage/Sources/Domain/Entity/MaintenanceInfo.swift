//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public struct MaintenanceInfo: Codable {
    public let isMaintenance: Bool
    public let maintenanceAlertTitle: String
    public let maintenanceAlertMessage: String

    public init(isMaintenance: Bool, maintenanceAlertTitle: String, maintenanceAlertMessage: String) {
        self.isMaintenance = isMaintenance
        self.maintenanceAlertTitle = maintenanceAlertTitle
        self.maintenanceAlertMessage = maintenanceAlertMessage
    }
}
