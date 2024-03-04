//
//  Created by sugurutakahashi on 2024/03/02
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import SwiftUI // for UIXXX

/// @mockable
public protocol DeviceInfoDriverProtocol {
    /// Bundle.main.infoDictionary["CFBundleShortVersionString"]
    /// ex) 1.2.3
    var appVersion: String { get }

    /// Bundle.main.infoDictionary["CFBundleVersion"]
    /// ex) 123
    var appBuildNumber: String { get }

    /// for DeviceKit SDK
    /// ex) "iPhone 14 Pro"
    var deviceName: String { get }

    /// ex) iPhone15,2, "iPad14,1"
    var deviceIdentifier: String { get }
    
    /// targetEnvironment(simulator)
    var isSimulator: Bool { get }
    
    /// ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    var isPreview: Bool { get }

    /// UIDevice.current.systemName
    /// ex) "iOS", "iPadOS"
    var osType: String { get }

    /// UIDevice.current.systemVersion
    /// ex) "16.2, "16.6"
    var osVersion: String { get }

    /// TimeZone.current.identifier
    /// ex) Asia/Tokyo
    var timezone: String { get }

    /// Locale.current.language.languageCode?.identifier
    /// ex) en
    var language: String { get }
}
