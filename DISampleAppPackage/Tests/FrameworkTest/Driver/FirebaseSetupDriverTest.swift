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

    @Test("初期化した時") func initialize() {
        #expect(true, "エラーが発生しないこと")
    }
}
