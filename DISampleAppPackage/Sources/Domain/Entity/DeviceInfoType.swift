//
//  Created by sugurutakahashi on 2024/03/03
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum DeviceInfoType {
    case appVersion
    case osVersion
    case buildScheme
    case buildConfiguration
    case isSimulator
    case deviceName
    case deviceIdentifier
    case timezone
    case language
    case uiUserInterfaceStyle
    case uiContentSize
}

extension DeviceInfoType: CaseIterable {}
