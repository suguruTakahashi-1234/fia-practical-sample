//
//  Created by sugurutakahashi on 2024/02/24
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import SwiftUI // for UIContentSizeCategory
import PreviewSnapshotsTesting
import PreviewSnapshots

enum SnapshotConfig {
    static let precision: Float = 0.95
    
    enum DeviceType: String, CaseIterable {
        case iPhoneSe = "iPhone-SE"
        case iPhone8 = "iPhone-8"
        case iPhone8Plus = "iPhone-8-Plus"
        case iPhoneX = "iPhone-X"
        case iPhoneXsMax = "iPhone-Xs-Max"
        case iPhoneXr = "iPhone-XR"
        case iPhone13Pro = "iPhone-13-Pro"
        case iPadPro11Portrait = "iPad-Pro-11-portrait"
        case iPadPro11Landscape = "iPad-Pro-11-landscape"
        
        static let defaultDevice: Self = .iPhone13Pro
        static let minDevice: Self = .iPhoneSe
        static let maxDevice: Self = .iPadPro11Portrait
        
        var viewImageConfig: ViewImageConfig {
            switch self {
            case .iPhoneSe:
                return .iPhoneSe
            case .iPhone8:
                return .iPhone8
            case .iPhone8Plus:
                return .iPhone8Plus
            case .iPhoneX:
                return .iPhoneX
            case .iPhoneXsMax:
                return .iPhoneXsMax
            case .iPhoneXr:
                return .iPhoneXr
            case .iPhone13Pro:
                return .iPhone13Pro
            case .iPadPro11Portrait:
                return .iPadPro11(.portrait)
            case .iPadPro11Landscape:
                return .iPadPro11(.landscape)
            }
        }
    }

    enum ContentSizeType: String, CaseIterable {
        case extraSmall = "extra-small"
        case small = "small"
        case medium = "medium"
        case large = "large"
        case extraLarge = "extra-large"
        case extraExtraLarge = "extra-extra-large"
        case extraExtraExtraLarge = "extra-extra-extra-large"
        case accessibilityMedium = "accessibility-medium"
        case accessibilityLarge = "accessibility-large"
        case accessibilityExtraLarge = "accessibility-extra-large"
        case accessibilityExtraExtraLarge = "accessibility-extra-extra-large"
        case accessibilityExtraExtraExtraLarge = "accessibility-extra-extra-extra-large"
        
        var size: UIContentSizeCategory {
            switch self {
            case .extraSmall:
                return .extraSmall
            case .small:
                return .small
            case .medium:
                return .medium
            case .large:
                return .large
            case .extraLarge:
                return .extraLarge
            case .extraExtraLarge:
                return .extraExtraLarge
            case .extraExtraExtraLarge:
                return .extraExtraExtraLarge
            case .accessibilityMedium:
                return .accessibilityMedium
            case .accessibilityLarge:
                return .accessibilityLarge
            case .accessibilityExtraLarge:
                return .accessibilityExtraLarge
            case .accessibilityExtraExtraLarge:
                return .accessibilityExtraExtraLarge
            case .accessibilityExtraExtraExtraLarge:
                return .accessibilityExtraExtraExtraLarge
            }
        }
    }
    
    static func previewTest<T: SnapshotTestable>(_ previews: T.Type, device: SnapshotConfig.DeviceType = .defaultDevice, file: StaticString = #file, function: String = #function, line: Int = #line) {
        previews.snapshots.assertSnapshots(
            as: .image(precision: SnapshotConfig.precision, layout: .device(config: device.viewImageConfig)),
            file: file,
            testName: function.testRemoveNamed,
            line: UInt(line)
        )
    }

    static func deviceVariationTest<T: SnapshotTestable>(_ previews: T.Type, file: StaticString = #file, function: String = #function, line: Int = #line) {
        SnapshotConfig.DeviceType.allCases.forEach { device in
            previews.snapshots.assertSnapshots(
                as: .image(precision: SnapshotConfig.precision, layout: .device(config: device.viewImageConfig)),
                named: device.rawValue,
                file: file,
                testName: function.testRemoveNamed,
                line: UInt(line)
            )
        }
    }

    static func contentSizeVariationTest<T: SnapshotTestable>(_ previews: T.Type, device: SnapshotConfig.DeviceType = .defaultDevice, file: StaticString = #file, function: String = #function, line: Int = #line) {
        SnapshotConfig.ContentSizeType.allCases.forEach { contentSizeType in
            previews.snapshots.assertSnapshots(
                as: .image(precision: SnapshotConfig.precision, layout: .device(config: device.viewImageConfig), traits: .init(preferredContentSizeCategory: contentSizeType.size)),
                named: "\(device.rawValue)-\(contentSizeType.rawValue)",
                file: file,
                testName: function.testRemoveNamed,
                line: UInt(line)
            )
        }
    }
}
