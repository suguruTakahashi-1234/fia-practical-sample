//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import FirebaseCore
import Foundation

public class FirebaseSetupDriver: FirebaseSetupDriverProtocol {
    public init() {
        LogDriver.initLog()
    }

    deinit {
        LogDriver.deinitLog()
    }

    public func configure() {
        FirebaseApp.configure()
    }
}
