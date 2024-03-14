//
//  Created by sugurutakahashi on 2024/03/14
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

public extension Data {
    /// Ref: Swiftでプッシュ通知用のDevice Token(Data型)を16進数文字列へ変換する方法 - https://qiita.com/mono0926/items/3cf0dca3029f32f54a09
    var deviceTokenHexString: String {
        map { String(format: "%.2hhx", $0) }.joined()
    }
}
