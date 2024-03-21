//
//  Created by sugurutakahashi on 2024/03/14
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

protocol UserDefaultsWrappable {
    associatedtype T: JSONCodable

    var key: UserDefaultsKey { get }
    var defaultValue: T? { get }
    var userDefaults: UserDefaults { get }

    func getFromUserDefaults() -> T?
    func saveToUserDefaults(oldValue: T?, newValue: T?)
}

extension UserDefaultsWrappable {
    func getFromUserDefaults() -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            // 未更新の key の場合はデフォルト値を返却する（準正常系）
            OSLogDriver.debugLog("Not found key in UserDefaults, key: \(key), return defaultValue: \(String(describing: defaultValue))")
            return defaultValue
        }

        do {
            let decodedValue = try T.decoder.decode(T?.self, from: data)
            OSLogDriver.debugLog("Return UserDefaults value, key: \(key), value: \(String(describing: decodedValue))", level: .debug)
            return decodedValue
        } catch {
            OSLogDriver.errorLog("Failed to decode \(key): \(error), defaultValue: \(String(describing: defaultValue)), data: \(data)", level: .fault)
            assertionFailure("Failed to decode \(key): \(error), defaultValue: \(String(describing: defaultValue))")
            return defaultValue
        }
    }

    func saveToUserDefaults(oldValue: T?, newValue: T?) {
        do {
            let encodedValue = try T.encoder.encode(newValue)
            userDefaults.set(encodedValue, forKey: key.rawValue)
            OSLogDriver.logging(.updateLocalDataStore(.init(key: key.rawValue, oldValue: String(describing: oldValue), newValue: String(describing: newValue))))
        } catch {
            OSLogDriver.errorLog("Failed to encode \(key): \(error), oldValue: \(String(describing: oldValue)), newValue: \(String(describing: newValue))", level: .fault)
            assertionFailure("Failed to encode \(key): \(error), oldValue: \(String(describing: oldValue)), newValue: \(String(describing: newValue))")
        }
    }
}
