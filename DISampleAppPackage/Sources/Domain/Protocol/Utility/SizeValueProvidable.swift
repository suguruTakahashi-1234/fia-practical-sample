//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol SizeValueProvider {
    static var sizeS: Self { get }
    static var sizeM: Self { get }
    static var sizeL: Self { get }
}

public extension Array where Element: SizeValueProvider {
    static var multipleSizeS: [Element] {
        [.sizeS]
    }

    static var multipleSizeM: [Element] {
        [.sizeM, .sizeM, .sizeM, .sizeM, .sizeM]
    }

    static var multipleSizeL: [Element] {
        [
            .sizeL, .sizeL, .sizeL, .sizeL, .sizeL,
            .sizeL, .sizeL, .sizeL, .sizeL, .sizeL,
            .sizeL, .sizeL, .sizeL, .sizeL, .sizeL,
        ]
    }
}
