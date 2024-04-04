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

        OSLogDriver.debugLog("Completed configure FirebaseSetupDriver")
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    public func configure() {
        if buildEnvDriver.buildScheme.isTesting {
            let fileName: String = "GoogleService-Info-For-Testing" // Staging 環境の GoogleService-Info.plist のコピー
            guard let filePath = Bundle.module.path(forResource: fileName, ofType: "plist"), let firebaseOptions = FirebaseOptions(contentsOfFile: filePath) else {
                OSLogDriver.errorLog("Unable to find \(fileName).plist in the bundle.")
                fatalError("Unable to find \(fileName).plist in the bundle.")
            }

            // テスト時などで 2回 configure が呼ばれるとエラーになるのでそれを回避するために FirebaseApp.app() == nil を判定している
            if FirebaseApp.app() == nil {
                // Bundle ID などが一致しないと warning が表示されるがテスト中に問題なければ、一旦、それでよし
                FirebaseApp.configure(options: firebaseOptions)
            }
        } else {
            // テスト時などで 2回 configure が呼ばれるとエラーになるのでそれを回避するために FirebaseApp.app() == nil を判定している
            if FirebaseApp.app() == nil {
                FirebaseApp.configure()
            }
        }
    }
}
