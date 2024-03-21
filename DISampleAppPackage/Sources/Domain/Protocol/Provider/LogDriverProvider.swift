//
//  Created by sugurutakahashi on 2024/03/11
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable(typealias: LogDriverProtocolAT = LogDriver<OSLogDriver, FirebaseLogDriverProtocolMock, FirebaseCrashlyticsLogDriverProtocolMock>)
public protocol LogDriverProvider {
    associatedtype LogDriverProtocolAT: LogDriverProtocol

    var logDriver: LogDriverProtocolAT { get }
}
