//
//  Created by sugurutakahashi on 2024/03/15
//  Copyright sugurutakahashi. All rights reserved.
//

import Foundation

extension Bool: RandomValueProvidable {
    public static var random: Bool {
        .random()
    }
}
