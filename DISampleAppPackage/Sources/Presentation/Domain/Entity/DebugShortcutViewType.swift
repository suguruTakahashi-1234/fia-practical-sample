//
//  Created by sugurutakahashi on 2024/04/30
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum DebugShortcutViewType {
    case deviceInfo
    case onboarding
    case licenseList
    case licenseDetail
    case taskList
}

/// for ForEach
extension DebugShortcutViewType: CaseIterable, Identifiable {
    public var id: String {
        "\(self)"
    }
}

// MARK: View Logic

import SwiftUI

public extension DebugShortcutViewType {
    var name: String {
        switch self {
        case .deviceInfo:
            String(localized: "デバイス情報", bundle: .module)
        case .onboarding:
            String(localized: "オンボーディング", bundle: .module)
        case .licenseList:
            String(localized: "ライセンス一覧", bundle: .module)
        case .licenseDetail:
            String(localized: "ライセンス詳細", bundle: .module)
        case .taskList:
            String(localized: "タスク一覧", bundle: .module)
        }
    }

    var image: some View {
        switch self {
        case .deviceInfo:
            SFSymbols.iphoneGen3.image
        case .onboarding:
            SFSymbols.book.image
        case .licenseList:
            SFSymbols.licenseplate.image
        case .licenseDetail:
            SFSymbols.licenseplateFill.image
        case .taskList:
            SFSymbols.pencilAndListClipboard.image
        }
    }

    var label: some View {
        Label(
            title: { Text(name) },
            icon: { self.image }
        )
    }
}
