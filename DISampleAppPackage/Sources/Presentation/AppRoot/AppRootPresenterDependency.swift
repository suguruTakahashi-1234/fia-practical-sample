//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation

/// @mockable
public protocol AppRootPresenterDependency {
    var osLogDriver: OSLogDriverProtocol { get }
    var firebaseSetupDriver: FirebaseSetupDriverProtocol { get }
}
