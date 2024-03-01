//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

/// @mockable(typealias: OSLogDriverProtocolAT = OSLogDriverProtocolMock; FirebaseSetupDriverProtocolAT = FirebaseSetupDriverProtocolMock)
public protocol AppRootPresenterDependency {
    associatedtype OSLogDriverProtocolAT: OSLogDriverProtocol
    associatedtype FirebaseSetupDriverProtocolAT: FirebaseSetupDriverProtocol

    var osLogDriver: OSLogDriverProtocolAT { get }
    var firebaseSetupDriver: FirebaseSetupDriverProtocolAT { get }
}
