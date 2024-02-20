//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

extension License: RandomValueProvidable {
    public static var random: License {
        .init(id: .random, name: .random, text: .random)
    }
}
