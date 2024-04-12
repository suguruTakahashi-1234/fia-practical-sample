//
//  Created by sugurutakahashi on 2024/03/16
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol PlaceholderProvider {
    static var placeholder: Self { get }
}

public extension Array where Element: PlaceholderProvider {
    static var placeholders: [Element] {
        [.placeholder]
    }
}
