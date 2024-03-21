//
//  Created by sugurutakahashi on 2024/03/11
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable(typealias: OSLogDriverProtocolAT = OSLogDriver; FirebaseAnalyticsLogDriverProtocolAT = FirebaseAnalyticsLogDriverProtocolMock; FirebaseCrashlyticsLogDriverProtocolAT = FirebaseCrashlyticsLogDriverProtocolMock;)
public protocol LogDriverDependency {
    associatedtype OSLogDriverProtocolAT: OSLogDriverProtocol
    associatedtype FirebaseAnalyticsLogDriverProtocolAT: FirebaseAnalyticsLogDriverProtocol
    associatedtype FirebaseCrashlyticsLogDriverProtocolAT: FirebaseCrashlyticsLogDriverProtocol

    var osLogDriver: OSLogDriverProtocolAT { get }
    var firebaseAnalyticsLogDriver: FirebaseAnalyticsLogDriverProtocolAT { get }
    var firebaseCrashlyticsLogDriver: FirebaseCrashlyticsLogDriverProtocolAT { get }
}
