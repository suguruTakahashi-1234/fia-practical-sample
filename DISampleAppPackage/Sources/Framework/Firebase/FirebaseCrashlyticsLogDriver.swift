//
//  Created by sugurutakahashi on 2024/03/21
//  Copyright sugurutakahashi. All rights reserved.
//

import DomainLayer
import FirebaseCrashlytics

public final class FirebaseCrashlyticsLogDriver<DeviceInfoDriver: DeviceInfoDriverProtocol>: FirebaseCrashlyticsLogDriverProtocol {
    private let deviceInfoDriver: DeviceInfoDriver

    public init(deviceInfoDriver: DeviceInfoDriver) {
        OSLogDriver.initLog()

        self.deviceInfoDriver = deviceInfoDriver
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    @MainActor
    public func identifyUser(userId: String) {
        let keysAndValues: [String: Any] = [
            "os_type": deviceInfoDriver.osType,
            "os_version": deviceInfoDriver.osVersion,
            "device_name": deviceInfoDriver.deviceName,
            "app_version": deviceInfoDriver.appVersion,
        ]
        Crashlytics.crashlytics().setUserID(userId)
        Crashlytics.crashlytics().setCustomKeysAndValues(keysAndValues)
    }

    public func clearUser() {
        Crashlytics.crashlytics().setUserID("")
        Crashlytics.crashlytics().setCustomKeysAndValues([:])
    }

    public func log(_ event: LogEventType, level: LogLevel, file: String, function: String, line: Int) {
        switch level {
        case .debug:
            // debug レベルのログは送信しないようにする
            break
        case .info, .notice, .error, .fault:
            Crashlytics.crashlytics().log("\(String(describing: event.logEvent)), logLevel: \(level.name), file: \(file), function: \(function), line: \(line)")
        }

        // AppError の場合は追加でエラーを送信する
        if case .error(let logEvent) = event {
            record(error: logEvent.appError)
        }
    }

    private func record(error: AppError) {
        // NSError 型だとCrashlytics がどのようなクラッシュであるかをグループ化できる
        // Ref: https://firebase.google.com/docs/crashlytics/customize-crash-reports?hl=ja&platform=ios
        Crashlytics.crashlytics().record(error: error.toNSError)
    }
}

private extension AppError {
    /// NSError の変換（他でも使うようなら Domain 層に移行する）
    var toNSError: NSError {
        NSError(domain: localizedDescription, code: "\(self)".hashValue)
    }
}
