//
//  Created by sugurutakahashi on 2024/02/24
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation
import PresentationLayer
import PreviewSnapshots
import PreviewSnapshotsTesting
import SwiftUI // for UIContentSizeCategory

enum SnapshotConfig {
    ///  一致率 ( 0.0-1.0 = 0-100% )
    static let precision: Float = 1.0

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
                .iPhoneSe
            case .iPhone8:
                .iPhone8
            case .iPhone8Plus:
                .iPhone8Plus
            case .iPhoneX:
                .iPhoneX
            case .iPhoneXsMax:
                .iPhoneXsMax
            case .iPhoneXr:
                .iPhoneXr
            case .iPhone13Pro:
                .iPhone13Pro
            case .iPadPro11Portrait:
                .iPadPro11(.portrait)
            case .iPadPro11Landscape:
                .iPadPro11(.landscape)
            }
        }
    }

    enum ContentSizeType: String, CaseIterable {
        case extraSmall = "extra-small"
        case small
        case medium
        case large
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
                .extraSmall
            case .small:
                .small
            case .medium:
                .medium
            case .large:
                .large
            case .extraLarge:
                .extraLarge
            case .extraExtraLarge:
                .extraExtraLarge
            case .extraExtraExtraLarge:
                .extraExtraExtraLarge
            case .accessibilityMedium:
                .accessibilityMedium
            case .accessibilityLarge:
                .accessibilityLarge
            case .accessibilityExtraLarge:
                .accessibilityExtraLarge
            case .accessibilityExtraExtraLarge:
                .accessibilityExtraExtraLarge
            case .accessibilityExtraExtraExtraLarge:
                .accessibilityExtraExtraExtraLarge
            }
        }
    }

    @MainActor
    static func previewTest(_ previews: (some SnapshotTestable).Type, device: SnapshotConfig.DeviceType = .defaultDevice, file: StaticString = #filePath, function: String = #function, line: Int = #line) {
        previews.snapshots.assertSnapshots(
            as: .image(precision: SnapshotConfig.precision, layout: .device(config: device.viewImageConfig)),
            file: file,
            testName: function.replacingOccurrences(of: "preview", with: ""),
            line: UInt(line)
        )
    }

    @MainActor
    static func previewDeviceVariationTest(_ previews: (some SnapshotTestable).Type, file: StaticString = #filePath, function: String = #function, line: Int = #line) {
        for device in SnapshotConfig.DeviceType.allCases {
            previews.snapshots.assertSnapshots(
                as: .image(precision: SnapshotConfig.precision, layout: .device(config: device.viewImageConfig)),
                named: device.rawValue,
                file: file,
                testName: function.replacingOccurrences(of: "previewDeviceVariation", with: ""),
                line: UInt(line)
            )
        }
    }

    @MainActor
    static func previewContentSizeVariationTest(_ previews: (some SnapshotTestable).Type, device: SnapshotConfig.DeviceType = .defaultDevice, file: StaticString = #filePath, function: String = #function, line: Int = #line) {
        for contentSizeType in SnapshotConfig.ContentSizeType.allCases {
            previews.snapshots.assertSnapshots(
                as: .image(precision: SnapshotConfig.precision, layout: .device(config: device.viewImageConfig), traits: .init(preferredContentSizeCategory: contentSizeType.size)),
                named: "\(device.rawValue)-\(contentSizeType.rawValue)",
                file: file,
                testName: function.replacingOccurrences(of: "previewContentSizeVariation", with: ""),
                line: UInt(line)
            )
        }
    }
}
