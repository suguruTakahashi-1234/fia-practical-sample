//
//  Created by sugurutakahashi on 2024/03/21
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable
public protocol FirebaseCrashlyticsLogDriverProtocol: LogDriverProtocol {
    @MainActor func identifyUser(userId: String)
    func clearUser()
}
