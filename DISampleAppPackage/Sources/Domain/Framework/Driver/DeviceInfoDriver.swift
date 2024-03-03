//
//  Created by sugurutakahashi on 2024/03/02
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import SwiftUI // for UIDevice

/// Development ビルドでも正しい値を用いたいので Domain 層の Driver でとして定義して、DeviceKit 依存の DeviceNameDriver のみを注入するようにしている
public struct DeviceInfoDriver<T: DeviceNameDriverProtocol>: DeviceInfoDriverProtocol {
    private let deviceNameDriver: T
    
    public init(deviceNameDriver: T) {
        self.deviceNameDriver = deviceNameDriver
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
    public var deviceIdentifier: String {
        UIDevice.current.deviceIdentifier
    }
    
    /// ex) "iOS", "iPadOS"
    public var osType: String {
        UIDevice.current.systemName
    }

    public var isSimulator: Bool {
        #if targetEnvironment(simulator)
          true
        #else
          false
        #endif
    }

    /// ex) "16.2, "16.6"
    public var osVersion: String {
        UIDevice.current.systemVersion
    }
    
    public var timezone: String {
        TimeZone.current.identifier
    }
    
    public var language: String {
        Locale.current.language.languageCode?.identifier ?? "unknown"
    }
    
    public var uiContentSizeCategory: UIContentSizeCategory {
        UIApplication.shared.preferredContentSizeCategory
    }
    
    public var uiUserInterfaceStyle: UIUserInterfaceStyle {
        UITraitCollection.current.userInterfaceStyle
    }
}
