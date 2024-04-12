//
//  Created by sugurutakahashi on 2024/03/04
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol SnakeCasedStructNameProvider {
    var instanceSnakeCasedStructName: String { get }
}

public extension SnakeCasedStructNameProvider {
    var instanceSnakeCasedStructName: String {
        String(describing: type(of: self)).toSnakeCase
    }
}
