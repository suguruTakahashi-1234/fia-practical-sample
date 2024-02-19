//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import FirebaseCore
import DomainLayer

public final class FirebaseSetupDriver: FirebaseSetupDriverProtocol {
    public init() {}

    public func configure() {
        FirebaseApp.configure()
    }
}
