//
//  Created by sugurutakahashi on 2024/03/02
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import SwiftUI // for UIDevice

/// Development ビルドでも正しい値を用いたいので Domain 層の Driver でとして定義して、DeviceKit 依存の DeviceNameDriver のみを注入するようにしている
public final class DeviceInfoDriver<T: DeviceNameDriverProtocol>: DeviceInfoDriverProtocol {
    private let deviceNameDriver: T

    public init(deviceNameDriver: T) {
        OSLogDriver.initLog()

        self.deviceNameDriver = deviceNameDriver
    }

    deinit {
        OSLogDriver.deinitLog()
    }

    /// ex) 1.2.3
    public var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
    }

    /// ex) 123
    public var appBuildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown"
    }

    /// ex) "iPhone 14 Pro"
    public var deviceName: String {
        deviceNameDriver.deviceName
    }

    /// ex) iPhone15,2, "iPad14,1"
    @MainActor // for UIDevice
    public var deviceIdentifier: String {
        #if os(iOS)
            UIDevice.current.deviceIdentifier
        #else
            ProcessInfo.processInfo.hostName
        #endif
    }

    /// ex) "iOS", "iPadOS"
    @MainActor // for UIDevice
    public var osType: String {
        #if os(iOS)
            UIDevice.current.systemName
        #else
            ProcessInfo.processInfo.operatingSystemVersionString
        #endif
    }

    /// ex) "16.2, "16.6"
    @MainActor // for UIDevice
    public var osVersion: String {
        #if os(iOS)
            UIDevice.current.systemVersion
        #else
            ""
        #endif
    }

    public var isSimulator: Bool {
        #if targetEnvironment(simulator)
            true
        #else
            false
        #endif
    }

    public var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }

    /// ex) Asia/Tokyo
    public var timezone: String {
        TimeZone.current.identifier
    }

    /// ex) en
    public var language: String {
        Locale.current.language.languageCode?.identifier ?? "unknown"
    }
}
