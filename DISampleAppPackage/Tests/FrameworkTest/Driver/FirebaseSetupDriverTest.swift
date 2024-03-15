//
//  Created by sugurutakahashi on 2024/03/15
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import FirebaseFramework
import Testing

struct FirebaseLogDriverTest {
    var firebaseSetupDriver: FirebaseSetupDriver!

    init() {
        firebaseSetupDriver = .init()
    }

    @Test("初期化した時") func initialize() {
        #expect(true, "エラーが発生しないこと")
    }
}
