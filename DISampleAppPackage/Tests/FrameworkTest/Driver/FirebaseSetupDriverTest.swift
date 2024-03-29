//
//  Created by sugurutakahashi on 2024/03/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import FirebaseFramework
import Testing

struct FirebaseAnalyticsLogDriverTest {
    var firebaseSetupDriver: FirebaseSetupDriver<BuildEnvDriver>!
    var buildEnvDriver: BuildEnvDriver!

    init() {
        buildEnvDriver = .init(buildScheme: .testing)
        firebaseSetupDriver = .init(buildEnvDriver: buildEnvDriver)
    }

    @Test("GoogleService-Info.plist の読み込みをした時") func configure() {
        firebaseSetupDriver.configure()
        #expect(true, "エラーが発生しないこと")
    }
}
