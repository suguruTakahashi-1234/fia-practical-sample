//
//  Created by sugurutakahashi on 2024/03/03
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum DeviceInfoType: Sendable {
    case appVersion
    case osVersion
    case buildScheme
    case buildConfiguration
    case isSimulator
    case isPreview
    case deviceName
    case deviceIdentifier
    case timezone
    case language
}

extension DeviceInfoType: CaseIterable {}

extension DeviceInfoType: RandomValueProvidableForEnum {}
