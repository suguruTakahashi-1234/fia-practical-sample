//
//  Created by sugurutakahashi on 2024/03/14
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol JSONCodable: Codable {
    static var decoder: JSONDecoder { get }
    static var encoder: JSONEncoder { get }
}

/// 必要に応じて、任意の decoder encoder を設定する場合は protocol の extension によるデフォルト実装を override する
public extension JSONCodable {
    static var decoder: JSONDecoder {
        JSONDecoder()
    }

    static var encoder: JSONEncoder {
        JSONEncoder()
    }
}

extension Int: JSONCodable {}
extension Bool: JSONCodable {}
extension Data: JSONCodable {}
