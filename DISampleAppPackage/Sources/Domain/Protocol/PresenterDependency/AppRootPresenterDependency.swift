//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol AppRootPresenterDependency {
    var osLogDriver: OSLogDriverProtocol { get }
    var firebaseSetupDriver: FirebaseSetupDriverProtocol { get }
}
