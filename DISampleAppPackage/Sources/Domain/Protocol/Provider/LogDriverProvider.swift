//
//  Created by sugurutakahashi on 2024/03/11
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable(typealias: LogDriverProtocolAT = LogDriver<OSLogDriver, FirebaseAnalyticsLogDriverProtocolMock, FirebaseCrashlyticsLogDriverProtocolMock>)
public protocol LogDriverProvider {
    associatedtype LogDriverProtocolAT: LogDriverProtocol

    var logDriver: LogDriverProtocolAT { get }
}
