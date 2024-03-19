//
//  Created by sugurutakahashi on 2024/03/05
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import Foundation
import Testing

struct LocalDataStoreTest {
    var localDataStore: LocalDataStore!

    init() {
        localDataStore = .init()
    }

    @Test("値を更新したとき") func update() {
        localDataStore.isCompletedOnboarding = true
        localDataStore.isCompletedOnboarding = false
        localDataStore.launchAppCount = .random
        localDataStore.launchAppCount = .random
        localDataStore.apnsToken = nil
        localDataStore.apnsToken = Data()
        localDataStore.apnsToken = nil
        #expect(true, "エラーが発生しないこと")
    }

    @Test("初期化したとき") func allClear() {
        localDataStore.isCompletedOnboarding = true
        localDataStore.launchAppCount = .random
        localDataStore.apnsToken = Data()

        #expect(localDataStore.isCompletedOnboarding != false, "前提条件の確認 isCompletedOnboarding")
        #expect(localDataStore.launchAppCount != 0, "前提条件の確認 launchAppCount")
        #expect(localDataStore.apnsToken != nil, "前提条件の確認 apnsToken")

        localDataStore.allClear()

        #expect(localDataStore.isCompletedOnboarding == false, "デフォルト値になっていること isCompletedOnboarding")
        #expect(localDataStore.launchAppCount == 0, "デフォルト値になっていること launchAppCount")
        #expect(localDataStore.apnsToken == nil, "デフォルト値になっていること apnsToken")
    }
}
