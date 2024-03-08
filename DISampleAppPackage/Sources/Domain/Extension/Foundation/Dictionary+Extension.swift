//
//  Created by sugurutakahashi on 2024/03/08
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public extension Dictionary where Value == Any {
    func trimmingValuesToMaxLength(_ maxLength: Int) -> [Key: Value] {
        mapValues { value in
            if let stringValue = value as? String, stringValue.count > maxLength {
                return String(stringValue.prefix(maxLength))
            }
            return value
        }
    }
}
