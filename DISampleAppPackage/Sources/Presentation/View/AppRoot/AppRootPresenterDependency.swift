//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

/// @mockable(typealias: FirebaseLogDriverProtocolAT = FirebaseLogDriverProtocolMock; FirebaseSetupDriverProtocolAT = FirebaseSetupDriverProtocolMock)
public protocol AppRootPresenterDependency {
    associatedtype FirebaseLogDriverProtocolAT: FirebaseLogDriverProtocol
    associatedtype FirebaseSetupDriverProtocolAT: FirebaseSetupDriverProtocol

    var firebaseLogDriver: FirebaseLogDriverProtocolAT { get }
    var firebaseSetupDriver: FirebaseSetupDriverProtocolAT { get }
}
