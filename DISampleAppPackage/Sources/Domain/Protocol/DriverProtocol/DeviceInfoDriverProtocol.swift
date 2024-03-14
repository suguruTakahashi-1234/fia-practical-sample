//
//  Created by sugurutakahashi on 2024/03/02
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import SwiftUI // for UIXXX

/// @mockable
public protocol DeviceInfoDriverProtocol: AnyObject {
    /// Bundle.main.infoDictionary["CFBundleShortVersionString"]
    /// ex) 1.2.3
    var appVersion: String { get }

    /// Bundle.main.infoDictionary["CFBundleVersion"]
    /// ex) 123
    var appBuildNumber: String { get }

    /// for DeviceKit SDK
    /// ex) "iPhone 14 Pro"
    var deviceName: String { get }

    /// from UIDevice.current
    /// ex) iPhone15,2, "iPad14,1"
    @MainActor // for UIDevice
    var deviceIdentifier: String { get }

    /// UIDevice.current.systemName
    /// ex) "iOS", "iPadOS"
    @MainActor // for UIDevice
    var osType: String { get }

    /// UIDevice.current.systemVersion
    /// ex) "16.2, "16.6"
    @MainActor // for UIDevice
    var osVersion: String { get }

    /// targetEnvironment(simulator)
    var isSimulator: Bool { get }

    /// ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    var isPreview: Bool { get }

    /// TimeZone.current.identifier
    /// ex) Asia/Tokyo
    var timezone: String { get }

    /// Locale.current.language.languageCode?.identifier
    /// ex) en
    var language: String { get }
}
