//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public struct AppUpdateInfo: Codable {
    public let minimumRequiredAppVersion: String
    public let appUpdateUrl: String
}
