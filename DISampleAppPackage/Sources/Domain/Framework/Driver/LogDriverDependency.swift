//
//  Created by sugurutakahashi on 2024/03/11
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

/// @mockable(typealias: OSLogDriverProtocolAT = OSLogDriver; FirebaseLogDriverProtocolAT = FirebaseLogDriverProtocolMock)
public protocol LogDriverDependency {
    associatedtype OSLogDriverProtocolAT: OSLogDriverProtocol
    associatedtype FirebaseLogDriverProtocolAT: FirebaseLogDriverProtocol

    var osLogDriver: OSLogDriverProtocolAT { get }
    var firebaseLogDriver: FirebaseLogDriverProtocolAT { get }
}
