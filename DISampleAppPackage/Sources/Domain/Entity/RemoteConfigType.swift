//
//  Created by sugurutakahashi on 2024/03/07
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public enum RemoteConfigType: CaseIterable {
    case appInfo
    case variantTest

    public init(keyName: String) throws {
        guard let matchingRemoteConfigType = RemoteConfigType.allCases.first(where: { $0.keyName == keyName }) else {
            throw AppError.customError("")
        }
        self = matchingRemoteConfigType
    }

    public var keyName: String {
        "\(self)".toSnakeCase
    }

    public var type: any RemoteConfigurable.Type {
        switch self {
        case .appInfo:
            AppInfo.self
        case .variantTest:
            VariantTest.self
        }
    }

    public var defaultValue: any RemoteConfigurable {
        type.defaultValue
    }
}
