//
//  Created by sugurutakahashi on 2024/03/16
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol PlaceholderProvidable {
    static var placeholder: Self { get }
}

public extension Array where Element: PlaceholderProvidable {
    static var placeholders: [Element] {
        [.placeholder]
    }
}
