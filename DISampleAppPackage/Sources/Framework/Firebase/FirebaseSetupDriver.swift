//
//  Created by sugurutakahashi on 2024/02/19
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import FirebaseCore
import Foundation

public final class FirebaseSetupDriver<BuildEnvDriver: BuildEnvDriverProtocol>: FirebaseSetupDriverProtocol {
    private let buildEnvDriver: BuildEnvDriver

    public init(buildEnvDriver: BuildEnvDriver) {
        OSLogDriver.initLog()

        self.buildEnvDriver = buildEnvDriver

        // Presenter で実行するまで configure() を呼べないと、他の Firebase SDK の API を一切使うことができないため、init で configure() を実行する
        configure()

        OSLogDriver.debugLog("Completed configure FirebaseSetupDriver")
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    private func configure() {
        switch buildEnvDriver.buildScheme {
        case .testing:
            let fileName: String = "GoogleService-Info-For-Testing" // Staging 環境の GoogleService-Info.plist のコピー
            guard let filePath = Bundle.module.path(forResource: fileName, ofType: "plist"), let firebaseOptions = FirebaseOptions(contentsOfFile: filePath) else {
                OSLogDriver.errorLog("Unable to find \(fileName).plist in the bundle.")
                fatalError("Unable to find \(fileName).plist in the bundle.")
            }

            // Bundle ID などが一致しない warning が表示されるがテスト中に問題なければ、一旦、それでよし
            FirebaseApp.configure(options: firebaseOptions)

        case .development:
            fatalError("unexpected")

        case .staging, .production:
            FirebaseApp.configure()
        }
    }
}
