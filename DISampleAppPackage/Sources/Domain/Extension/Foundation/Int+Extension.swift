//
//  Created by sugurutakahashi on 2024/03/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

extension Int: RandomValueProvider {
    public static var random: Int {
        anyInteger
    }

    /// 正の自然数（0含む）
    public static var positiveWithZero: Int {
        .random(in: 0...10000)
    }

    /// 正の自然数（0含まず）
    public static var positiveWithoutZero: Int {
        .random(in: 1...10000)
    }

    /// 負の整数（0含む）
    public static var negativeWithZero: Int {
        .random(in: -10000...0)
    }

    /// 負の整数（0含まず）
    public static var negativeWithoutZero: Int {
        .random(in: -10000..<0)
    }

    /// 整数全体
    public static var anyInteger: Int {
        .random(in: -10000...10000)
    }
}

extension Int: PlaceholderProvider {
    public static var placeholder: Int {
        999_999
    }
}
