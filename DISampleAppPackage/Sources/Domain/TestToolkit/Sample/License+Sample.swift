//
//  Created by sugurutakahashi on 2024/02/17
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

extension License: SampleValueProvidable {
    public static var sample: License {
        .init(id: .random, name: .random, text: .random)
    }
}
