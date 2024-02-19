//
//  Created by sugurutakahashi on 2024/02/20
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

extension String: RandomValueProvidable {
    public static var random: String {
        random(count: Int.random(in: 0...256))
    }

    public static func random(count: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""

        for _ in 0..<count {
            let randomValue = Int.random(in: 0..<base.count)
            let index: Index = base.index(base.startIndex, offsetBy: randomValue)
            let character: Character = base[index]
            randomString += String(character)
        }
        return randomString
    }
}
