//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import FirebaseCore
import Foundation

public final class FirebaseSetupDriver: FirebaseSetupDriverProtocol {
    public init() {
        OSLogDriver.initLog()

        // Presenter で実行するまで configure() を呼べないと、他の Firebase SDK の API を一切使うことができないため、init で configure() を実行する
        configure()

        OSLogDriver.debugLog("Completed configure FirebaseSetupDriver")
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    private func configure() {
        FirebaseApp.configure()
    }
}
