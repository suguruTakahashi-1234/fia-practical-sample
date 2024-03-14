//
//  Created by sugurutakahashi on 2024/03/14
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public final class LocalDataStore: LocalDataStoreProtocol {
    @UserDefaultsWrapper(key: .launchAppCount, defaultValue: 0)
    public var launchAppCount: Int

    @UserDefaultsWrapper(key: .isFirstLaunch, defaultValue: true)
    public var isFirstLaunch: Bool

    @UserDefaultsWrapperNilable(key: .apnsToken, defaultValue: nil)
    public var apnsToken: Data?

    public init() {
        OSLogDriver.initLog()
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    public func allClear() {
        guard let domain = Bundle.main.bundleIdentifier else {
            OSLogDriver.errorLog("Bundle.main.bundleIdentifier is nil", level: .fault)
            assertionFailure("Bundle.main.bundleIdentifier is nil")
            return
        }
        UserDefaults.standard.removePersistentDomain(forName: domain)
        OSLogDriver.errorLog("Completed: clear userDefaults")
    }
}
