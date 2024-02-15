//
//  Created by sugurutakahashi on 2024/02/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol ConvertibleToDictionary {
    func toDictionary(caseFormat: CaseFormat) -> [String: Any]
}

public extension ConvertibleToDictionary {
    /// 以下の処理は Mirror ではなくて、Codable で書き直すことも検討したのですが、以下の記事のようにやりたいことが達成できなかったので、Mirror 使用している
    // Ref: [Swift] JSONSerialization を使って辞書型に変換すると数値や Bool 値の型が勝手に変更されてしまう件 https://zenn.dev/ikuraikura/articles/2023-08-12-dict
    func toDictionary(caseFormat: CaseFormat = .original) -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictionary: [String: Any] = [:]

        mirror.children.forEach { child in
            guard let keyName = child.label else {
                return
            }

            switch caseFormat {
            case .original:
                dictionary[keyName] = child.value
            case .snakeCase:
                dictionary[keyName.toSnakeCase] = child.value
            }
        }

        return dictionary
    }
}
