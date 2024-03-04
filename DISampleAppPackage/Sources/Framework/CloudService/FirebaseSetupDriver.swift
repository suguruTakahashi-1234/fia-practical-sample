//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import FirebaseCore
import Foundation

public struct FirebaseSetupDriver: FirebaseSetupDriverProtocol {
    public init() {
        LogDriver.initLog()
    }

    public func configure() {
        FirebaseApp.configure()
    }
}
