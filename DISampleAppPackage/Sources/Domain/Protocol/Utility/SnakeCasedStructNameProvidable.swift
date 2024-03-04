//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol SnakeCasedStructNameProvidable {
    var instanceSnakeCasedStructName: String { get }
}

public extension SnakeCasedStructNameProvidable {
    var instanceSnakeCasedStructName: String {
        String(describing: type(of: self)).toSnakeCase
    }
}
