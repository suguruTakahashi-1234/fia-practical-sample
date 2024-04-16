//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public protocol RandomValueProviderForEnum: CaseIterable {
    static var random: Self { get }
}

public extension RandomValueProviderForEnum {
    static var random: Self {
        allCases.randomElement()!
    }
}

public extension Array where Element: RandomValueProviderForEnum {
    static var randomSamples: [Element] {
        randomSamples(count: 5)
    }

    static func randomSamples(count: Int) -> [Element] {
        (0..<count).map { _ in Element.random }
    }

    static func randomSamples(countRange: ClosedRange<Int> = 0...3, isEmptyAllowed: Bool = false) -> [Element] {
        let adjustedRange = isEmptyAllowed ? countRange : (Swift.max(1, countRange.lowerBound)...countRange.upperBound)
        return randomSamples(count: Int.random(in: adjustedRange))
    }
}
