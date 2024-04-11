//
//  Created by sugurutakahashi on 2024/03/05
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation
import Testing

struct LocalDataStoreDriverTest {
    var localDataStoreDriver: LocalDataStoreDriver!

    init() {
        localDataStoreDriver = .init()
    }

    @Test("値を更新したとき") func update() {
        localDataStoreDriver.isCompletedOnboarding = true
        localDataStoreDriver.isCompletedOnboarding = false
        localDataStoreDriver.launchAppCount = .random
        localDataStoreDriver.launchAppCount = .random
        localDataStoreDriver.apnsToken = nil
        localDataStoreDriver.apnsToken = Data()
        localDataStoreDriver.apnsToken = nil
        #expect(true, "エラーが発生しないこと")
    }

    @Test("初期化したとき") func allClear() {
        localDataStoreDriver.isCompletedOnboarding = true
        localDataStoreDriver.launchAppCount = .random
        localDataStoreDriver.apnsToken = Data()

        #expect(localDataStoreDriver.isCompletedOnboarding != false, "前提条件の確認 isCompletedOnboarding")
        #expect(localDataStoreDriver.launchAppCount != 0, "前提条件の確認 launchAppCount")
        #expect(localDataStoreDriver.apnsToken != nil, "前提条件の確認 apnsToken")

        localDataStoreDriver.allClear()

        #expect(localDataStoreDriver.isCompletedOnboarding == false, "デフォルト値になっていること isCompletedOnboarding")
        #expect(localDataStoreDriver.launchAppCount == 0, "デフォルト値になっていること launchAppCount")
        #expect(localDataStoreDriver.apnsToken == nil, "デフォルト値になっていること apnsToken")
    }
}
