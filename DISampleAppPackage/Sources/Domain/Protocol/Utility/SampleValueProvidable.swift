//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol SampleValueProvidable {
    static var sample: Self { get }
}

public extension Array where Element: SampleValueProvidable {
    static var samples: [Element] {
        samples()
    }

    static var emptySample: [Element] {
        []
    }

    static func samples(count: Int) -> [Element] {
        (0..<count).map { _ in Element.sample }
    }

    static func samples(countRange: ClosedRange<Int> = 0...5, isEmptyAllowed: Bool = false) -> [Element] {
        let adjustedRange = isEmptyAllowed ? countRange : (Swift.max(1, countRange.lowerBound)...countRange.upperBound)
        return samples(count: Int.random(in: adjustedRange))
    }
}
