//
//  Created by sugurutakahashi on 2024/03/14
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefaultsWrapper<T: JSONCodable>: UserDefaultsWrappable {
    let key: UserDefaultsKey
    let defaultValue: T?
    let userDefaults: UserDefaults

    public init(key: UserDefaultsKey, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

    public var wrappedValue: T {
        get {
            getFromUserDefaults()!
        }
        set {
            saveToUserDefaults(oldValue: wrappedValue, newValue: newValue)
        }
    }
}
