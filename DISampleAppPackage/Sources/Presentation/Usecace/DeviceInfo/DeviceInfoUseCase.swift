//
//  Created by sugurutakahashi on 2024/03/06
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

/// Usecase はモックの差し替えをしないので mockable には適応させない
public protocol DeviceInfoUseCase {
    func getDeviceInfoValue(_ deviceInfoType: DeviceInfoType) -> String
}
