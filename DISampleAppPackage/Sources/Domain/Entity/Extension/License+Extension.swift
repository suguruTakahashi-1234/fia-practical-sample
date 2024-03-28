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

extension License: SizeValueProvidable {
    public static var sizeS: License {
        .init(id: .random, name: .sizeS, text: .sizeS)
    }

    public static var sizeM: License {
        .init(id: .random, name: .sizeM, text: .sizeM)
    }

    public static var sizeL: License {
        .init(id: .random, name: .sizeL, text: .sizeL)
    }
}

extension License: PlaceholderProvidable {
    public static var placeholder: License {
        .init(id: .random, name: .placeholder, text: .placeholder)
    }
}
