//
//  Created by sugurutakahashi on 2024/03/06
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import DomainLayer

// Usecase はモックの差し替えをしないので mockable には適応させない
public protocol DeviceInfoUsecase {
    func getDeviceInfoValue(_ deviceInfoType: DeviceInfoType) -> String
}
