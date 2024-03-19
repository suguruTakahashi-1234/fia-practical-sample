//
//  Created by sugurutakahashi on 2024/03/14
//  Copyright sugurutakahashi. All rights reserved.
//

import Combine
import Foundation

public final class LocalDataStore: LocalDataStoreProtocol {
    private let isCompletedOnboardingSubject = PassthroughSubject<Bool, Never>()

    public var isCompletedOnboardingPublisher: AnyPublisher<Bool, Never> {
        isCompletedOnboardingSubject.eraseToAnyPublisher()
    }

    @UserDefaultsWrapper(key: .launchAppCount, defaultValue: 0)
    public var launchAppCount: Int

    @UserDefaultsWrapper(key: .isCompletedOnboarding, defaultValue: false)
    public var isCompletedOnboarding: Bool {
        didSet {
            isCompletedOnboardingSubject.send(isCompletedOnboarding)
        }
    }

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
        OSLogDriver.debugLog("Completed: clear userDefaults")
    }
}
